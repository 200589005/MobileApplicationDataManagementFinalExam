//
//  LoginViewController.swift

//  Created by Mitul Patel on 08/06/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func isValidDetails() -> Bool {
        if let text = txtEmail.text, text.isBlank {
            self.showAlert(string: "Please enter email")
            return false
        } else if let text = txtEmail.text, !text.isEmail {
            self.showAlert(string: "Please enter valid email")
        } else if let text = txtPassword.text, text.isBlank {
            self.showAlert(string: "Please enter Password")
        }
        
        return true
    }
    
    func navigateToMovieList() {
        txtEmail.text = ""
        txtPassword.text = ""
        let movieList: MovieListViewController = MovieListViewController.instantiateViewController(identifier: .main)
        self.pushVC(movieList)
    }
    
    // MARK: - IBActions
    @IBAction func btnLoginAction(_ sender: UIButton) {
        if self.isValidDetails() {
            guard let email = txtEmail.text, let password = txtPassword.text else {
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    print("Error logging in: \(error.localizedDescription)")
                    self.showAlert(string: "Invalid Email or password.")
                    return
                }
                
                self.navigateToMovieList()
            }
            
        }
    }
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        let signUpVC = SignupViewController.instantiateViewController(identifier: .main)
        self.pushVC(signUpVC)
    }
    
    @IBAction func btnForgotPassword(_ sender: UIButton) {
        if let text = txtEmail.text, text.isBlank {
            self.showAlert(string: "Please enter valid email befor forgot password.")
        } else if let text = txtEmail.text, !text.isEmail {
            self.showAlert(string: "Please enter valid email befor forgot password")
        }
        
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text ?? "") { error in
            if let error = error {
                self.showAlert(string: "Error: \(error.localizedDescription)")
            } else {
                self.showAlert(string: "Password reset email sent. Please check your inbox.")
            }
        }
        
    }
    
    
}
