//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Mitul Patel on 29/06/24.
//

import UIKit
import CoreData
import FirebaseFirestore
import FirebaseAuth

class MovieListViewController: UIViewController {

    var arrMovies: [MovieModel] = []
    let db = Firestore.firestore()
    
    @IBOutlet weak var tblMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAndSetMovies()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getAndSetMovies() {
        let userID = Auth.auth().currentUser?.uid ?? ""
        db.collection("Movies").document(userID).collection(userID).getDocuments { (querySnapshot, error) in
            if let error = error {
                
                return
            }
            var arr: [[String:Any]] = []
            for document in querySnapshot!.documents {
                var data = document.data()
                data["docID"] = document.documentID
                arr.append(data)
            }
            var arrModels = arr.compactMap({ MovieModel(dictData: $0)})
            self.arrMovies = arrModels
            DispatchQueue.main.async {
                self.tblMovies.reloadData()
            }
        }
        
    }
    
    func registerTableViewCells() {
        tblMovies.register(UINib.init(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        tblMovies.rowHeight = UITableView.automaticDimension
        tblMovies.estimatedRowHeight = 30;
        tblMovies.tableFooterView = UIView()
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.reloadData()
        self.setupDefaultNavigation()
        self.navigationItem.hidesBackButton = true
    }
    
    func navigateToAddMovies(movie: MovieModel) {
        let addMovies: AddMoviesViewController = AddMoviesViewController.instantiateViewController(identifier: .main)
        addMovies.movie = movie
        self.pushVC(addMovies)
    }
    
    @IBAction func btnAddAction(_ sender: UIBarButtonItem) {
        let addMovies: AddMoviesViewController = AddMoviesViewController.instantiateViewController(identifier: .main)
        self.pushVC(addMovies)
    }
    
    @IBAction func btnLogoutAction(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            // Navigate to the login screen or any other action after logout
            self.popToRootVC()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
}

extension MovieListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMovies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as? MovieListTableViewCell {
            cell.indexPath = indexPath
            cell.delegate = self
            cell.cellConfig(modal: arrMovies[indexPath.row])
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension MovieListViewController: MovieListTableViewCellProtocol {
    func deleteMoviesAtIndex(indexPath: IndexPath) {
        self.showAlertWithOkAndCancelHandler(string: "Are you sure you want to delete this movies?", strOk: "YES", strCancel: "NO") { isOkBtnPressed in
            if isOkBtnPressed {
                let movie = self.arrMovies.remove(at: indexPath.row)
                let userID = Auth.auth().currentUser?.uid ?? ""
                self.db.collection("Movies").document(userID).collection(userID).document(movie.docID).delete()
                DispatchQueue.main.async {
                    self.tblMovies.reloadData()
                }
            }
        }
        
    }
    
    func editMoviesAtIndex(indexPath: IndexPath) {
        self.navigateToAddMovies(movie: arrMovies[indexPath.row])
    }
}
