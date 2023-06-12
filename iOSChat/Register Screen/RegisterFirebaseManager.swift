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
                } else {
                    completion(authDataResult?.user, nil)
                }
            }
        }
    }
}
