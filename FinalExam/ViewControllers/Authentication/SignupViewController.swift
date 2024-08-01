//
//  SignupViewController.swift

//  Created by Mitul Patel on 08/06/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignupViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var txtEmail: AppThemeTextField!
    @IBOutlet weak var txtPassword: AppThemeTextField!
    @IBOutlet weak var txtConfirmPassword: AppThemeTextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "mitulyaar92@gmail.com"
        txtPassword.text = "12345678"
        txtConfirmPassword.text = "12345678"
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
        }
        return true
    }
    
    
    func navigateToMovieList() {
        let movieList: MovieListViewController = MovieListViewController.instantiateViewController(identifier: .main)
        self.pushVC(movieList)
    }
    
    func getAndSetupInitialDB() -> [[String:Any]]? {
        if let path = Bundle.main.path(forResource: "db_movies", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:Any]] {
                            // do stuff
                    return jsonResult
                  }
              } catch {
                   // handle error
              }
        }
        return nil
    }
    
    // MARK: - IBActions
    @IBAction func btnSIngupAction(_ sender: UIButton) {
        if self.isValidDetails() {
            Auth.auth().createUser(withEmail: txtEmail.text ?? "", password: txtPassword.text ?? "") { (authResult, error) in
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                    return
                }
                guard let arr = self.getAndSetupInitialDB() else { return }
                
                var count = 0
                let collection = self.db.collection("Movies").document(authResult?.user.uid ?? "").collection(authResult?.user.uid ?? "")
                for item in arr  {
                    guard let id = item["id"] as? String else { return }
                    collection.addDocument(data: item) { error in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                        count += 1
                        if arr.count == count {
                            DispatchQueue.main.async {
                                self.showAlertwithOkHandler(string: "Signup successfully Done", strBtnTitle: "Ok") {
                                    self.navigateToMovieList()
                                }
                            }
                        }
                    }
                    
                }
                
//                self.db.collection("Movies").document(authResult?.user.uid ?? "").setData(["jsonarray": arr]) { error in
//                    if let error = error {
//                        print("Error writing document: \(error.localizedDescription)")
//                    } else {
//                        
//                    }
//                }
                
            }
            
        }
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        self.popVC()
    }
    
}
