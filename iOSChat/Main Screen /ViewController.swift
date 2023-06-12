import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()

    var usersList = [User]()

    var handleAuth: AuthStateDidChangeListenerHandle?

    var currentUser: User?

    let database = Firestore.firestore()

    let childProgressView = ProgressSpinnerViewController()

    override func loadView() {
        view = mainScreen
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            print("auth user: ", user?.uid)
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in to see the chats!"

                //MARK: Reset tableView...
                self.usersList.removeAll()
                self.mainScreen.tableViewContacts.reloadData()

                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)

            }else{
                //MARK: the user is signed in...
                let userData = self.database.collection("users").document(user!.uid)
                userData.getDocument { (document, error) in
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: User.self)
                            self.currentUser = user
                            self.mainScreen.labelText.text = "Welcome \(user.name)!"
                        } catch {
                            print("Error decoding user data: \(error)")
                        }
                    } else {
                        print("User document does not exist")
                    }
                }
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users").getDocuments { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        var userIds: [User] = []
                        for document in querySnapshot!.documents {
                            do {
                                if (document.documentID != self.currentUser?.id) {
                                    let user = try document.data(as: User.self)
                                    userIds.append(user)
                                }
                            } catch {
                                print("Error decoding user data: \(error)")
                            }
                        }
                        self.usersList = userIds.sorted { $0.name < $1.name }
                        print("userlist: ", self.usersList)
                        print("end")
                        self.mainScreen.tableViewContacts.reloadData()
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Contacts"

        //MARK: patching table view delegate and data source...
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.dataSource = self

        //MARK: removing the separator line...
        mainScreen.tableViewContacts.separatorStyle = .none

        //MARK: Make the titles look large...
navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }

    func openChat(user: User){
        let viewChatViewController = ViewChatViewController()
        viewChatViewController.userSelf = self.currentUser
        viewChatViewController.userOther = user
        navigationController?.pushViewController(viewChatViewController, animated: true)
    }
}
