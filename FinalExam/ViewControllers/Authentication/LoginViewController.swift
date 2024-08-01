//
//  LoginViewController.swift
//  Dhanify
//
//  Created by Mitul Patel on 08/06/24.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    func navigateToTab() {
        txtEmail.text = ""
        txtPassword.text = ""
        
    }
    
    // MARK: - IBActions
    @IBAction func btnLoginAction(_ sender: UIButton) {
        if self.isValidDetails() {
        
           
            
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
        
        
         
    }
    
    
}
