//
//  DashboardViewController.swift
//  FinalExam
//
//  Created by Mitul Patel on 01/08/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DashboardViewController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnLogoutAction(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid ?? ""
        
        db.collection("Movies").document(userID).collection(userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                
                return
            }
            
            
            for document in querySnapshot!.documents {
                let data = document.data()
                document.documentID
                print("data : ",data)
            }
        }
        
//        do {
//            try Auth.auth().signOut()
//            // Navigate to the login screen or any other action after logout
//            self.popToRootVC()
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
    }
}
