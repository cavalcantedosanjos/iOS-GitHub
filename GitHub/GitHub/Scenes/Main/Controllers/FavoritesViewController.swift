//
//  FavoritesViewController.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class FavoritesViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var emptyView: UIView!
    var repos: [Repository] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setupUI()
    }
    
    // MARK: - MISCk
    func setupUI() {
        repos = CoreDataConvinience().load()
        tableview.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableview.separatorStyle = (repos.count == 0) ? .none : .singleLine
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteTableViewCell.self)) as! FavoriteTableViewCell
        cell.setup(with: repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let vc = RepositoryDetailViewController.initiateNew()
            vc.repo = self.repos[indexPath.row]
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}

// MARK: -
extension FavoritesViewController: DZNEmptyDataSetSource {
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return emptyView
    }
}

// MARk: - RepositoryDetailViewControllerDelegate
extension FavoritesViewController: RepositoryDetailViewControllerDelegate {
    
    func repositoryDetailViewControllerDidDismiss(controller: RepositoryDetailViewController) {
        repos = CoreDataConvinience().load()
        tableview.reloadData()
    }
    
}
