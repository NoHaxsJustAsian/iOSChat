import Foundation
import FirebaseAuth

extension RegisterViewController{
    
    func registerNewAccount(completion: @escaping (FirebaseAuth.User?, Error?) -> Void) {
        //MARK: display the progress indicator...
        showActivityIndicator()

        //MARK: create a Firebase user with email and password...
        if let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text{
            //Validations....
            Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
                if let error = error {
                    print("Error: \(error)")
                    completion(nil, error)
                    let errorString = error.localizedDescription
                    if errorString.contains("already in use"){
                        self.showAlert(title:"Error!", message:"The email address is already in use by another account.")
                    }
                    if errorString.contains("must be provided."){
                        self.showAlert(title:"Error!", message:"An email address must be provided.")
                    }
                    if errorString.contains("badly formatted"){
                        self.showAlert(title:"Error!", message:"The email address is badly formatted.")
                    }
                    if errorString.contains("6 characters long"){
                        self.showAlert(title:"Error!", message:"The password must be 6 characters long or more.")
                    }
                    self.hideActivityIndicator()
                } else {
                    completion(authDataResult?.user, nil)
                    self.hideActivityIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
