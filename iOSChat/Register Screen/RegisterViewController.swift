import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    let database = Firestore.firestore()

    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        registerNewAccount { user, error in
            if let error = error {
                print("Error: \(error)")
            } else if let user = user {
                let name = self.registerView.textFieldName.text
                self.database.collection("users").document(user.uid).setData([
                    "name": name
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(user.uid)")
                    }
                }
            }
        }
    }
}
