//
//  SearchUserViewController.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users: [User] = []
    
    let kUserDetailViewControllerSegue = "UserDetailViewControllerSegue"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kUserDetailViewControllerSegue {
            let vc = segue.destination as! UserDetailViewController
            vc.user = sender as? User
        }
    }
    
    
    // MARK: - Services
    func getUser(by name: String) {
        
        self.startLoading()
        
        GitService().getUser(by: name, onSuccess: { (users) in
            
            guard let users = users else { return }
            self.users = users
            
        }, onFailure: { (error) in
            self.showAlert(title: "", message: error.message ?? "", buttonTitle: "OK", dissmisBlock: {
                // Nothing
            })
        }, onCompleted: {
            self.stopLoading()
            self.tableView.reloadData()
        })
    }

}


// MARK: - UITableViewDataSource
extension SearchUserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self)) as! UserTableViewCell
        cell.setup(with: users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

// MARK: - UITableViewDelegate
extension SearchUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: kUserDetailViewControllerSegue, sender: users[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate
extension SearchUserViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        getUser(by: searchBar.text!)
    }
    
}
