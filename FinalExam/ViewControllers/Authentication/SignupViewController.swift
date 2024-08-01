//
//  SignupViewController.swift
//  Dhanify
//
//  Created by Mitul Patel on 08/06/24.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var txtFullName: AppThemeTextField!
    @IBOutlet weak var txtEmail: AppThemeTextField!
    @IBOutlet weak var txtPassword: AppThemeTextField!
    @IBOutlet weak var txtConfirmPassword: AppThemeTextField!
    @IBOutlet weak var txtSecurityQuestion1: AppThemeTextField!
    @IBOutlet weak var txtAnswer: AppThemeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isValidDetails() -> Bool {
        if let text = txtFullName.text, text.isBlank {
            self.showAlert(string: "Please enter full name.")
            return false
        } else if let text = txtFullName.text, text.count <= 2 {
            self.showAlert(string: "Please enter at least 3 characters for the name")
            return false
        } else if let text = txtEmail.text, text.isBlank {
            self.showAlert(string: "Please enter email")
            return false
        } else if let text = txtEmail.text, !text.isEmail {
            self.showAlert(string: "Please enter valid email")
            return false
        } else if let text = txtPassword.text, text.isBlank {
            self.showAlert(string: "Please enter password")
            return false
        } else if let text = txtPassword.text, text.count < 8 {
            self.showAlert(string: "Please enter minimam 8 character in password")
            return false
        } else if let text = txtConfirmPassword.text, text.isBlank {
            self.showAlert(string: "Please enter confirm password")
            return false
        } else if let textPassword = txtPassword.text, let textConfirm = txtConfirmPassword.text, textPassword != textConfirm {
            self.showAlert(string: "Password and confirm password should be same")
            return false
        } else if let text = txtSecurityQuestion1.text, text.isBlank {
            self.showAlert(string: "Please enter valid security question")
            return false
        } else if let text = txtAnswer.text, text.isBlank {
            self.showAlert(string: "Please enter valid answer for sequrity question")
            return false
        }
        return true
    }
    
    func createDictData() -> [String:Any] {
        var dictParam : [String:Any] = [:]
        dictParam["name"] = txtFullName.text ?? ""
        dictParam["email"] = (txtEmail.text ?? "").lowercased()
        dictParam["password"] = txtPassword.text ?? ""
        dictParam["securityquestion1"] = txtSecurityQuestion1.text ?? ""
        dictParam["securityanswer1"] = txtAnswer.text ?? ""
        return dictParam
    }
    
    func navigateToTab() {
//        let tabVC = MainTabbarViewController.instantiateViewController(identifier: .tab)
//        self.pushVC(tabVC)
    }
    
    // MARK: - IBActions
    @IBAction func btnSIngupAction(_ sender: UIButton) {
        if self.isValidDetails() {
            
            let dict = self.createDictData()
            
            self.showAlertwithOkHandler(string: "Signup successfully Done", strBtnTitle: "Ok") {
                self.navigateToTab()
            }
        }
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.popVC()
    }
    
}
