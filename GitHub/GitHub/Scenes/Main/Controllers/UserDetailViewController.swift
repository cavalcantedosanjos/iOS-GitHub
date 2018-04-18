//
//  UserDetailViewController.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user:User?
    
    var repos: [Repository] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - MISCk
    func setupUI() {
        guard  let user = user else { return }
        
        self.title = user.login
        
        loginLabel.text = user.login ?? ""
        scoreLabel.text = "Score: \(Int(user.score ?? 0))"
        logoImageView.loadImage(urlString: user.avatar_url!)
        
        logoImageView.layer.cornerRadius = 5.0
        
        repos = CoreDataConvinience().load(by: user)
        getRepositories()
        
    }
    
    // MARK: - Services
    func getRepositories() {
        guard let url = user?.repos_url else {
            return
        }
        
        self.startLoading()

        GitService().getRepositories(url: url, onSuccess: { (repositories) in
            guard let repos = repositories else { return }
            
            for r in repos {
                if !(self.repos.contains(where: { $0.id ?? 0 == r.id ?? 0})) {
                    self.repos.append(r)
                }
            }
        }, onFailure: { (error) in
            self.showAlert(title: "", message: error.message ?? "", buttonTitle: "OK", dissmisBlock: {
                // Nothing
            })
        }, onCompleted: {
            self.tableView.reloadData()
            self.stopLoading()
        })
    }
    
}


// MARK: - UITableViewDataSource
extension UserDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self)) as! RepositoryTableViewCell
        cell.setup(with: repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - UITableViewDelegate
extension UserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let vc = RepositoryDetailViewController.initiateNew()
            vc.repo = self.repos[indexPath.row]
            self.present(vc, animated: true, completion: nil)
        }

    }
}

