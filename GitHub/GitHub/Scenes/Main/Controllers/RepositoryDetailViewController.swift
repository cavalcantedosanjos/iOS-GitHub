//
//  RepositoryDetailViewController.swift
//  GitHub
//
//  Created by Joao Paulo Cavalcante dos Anjos on 4/5/18.
//  Copyright © 2018 Joao Paulo Cavalcante dos Anjos. All rights reserved.
//

import UIKit

protocol RepositoryDetailViewControllerDelegate {
    func repositoryDetailViewControllerDidDismiss(controller: RepositoryDetailViewController)
}

class RepositoryDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var linguageLabel: UILabel!
    @IBOutlet weak var startsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var repo: Repository?
    var delegate: RepositoryDetailViewControllerDelegate?
    
    // MARK: - LifeCycle
    class func initiateNew() -> RepositoryDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RepositoryDetailViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func favoriteButtonDidReceiveTouchUpInside(_ sender: UIButton) {
       favoriteButton.isSelected = !favoriteButton.isSelected
        if let repo = repo {
            if (favoriteButton.isSelected) {
                CoreDataConvinience().save(repository: repo)
            } else {
                CoreDataConvinience().delete(repository: repo)
            }
        }
    }
    
    @IBAction func closeButtonDidReceiveTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.repositoryDetailViewControllerDidDismiss(controller: self)
        }
    }
    
    // MARK: - MISC
    
    func setupUI() {
        setupBlur()
        
        guard let repo = repo else {
            return
        }
        
        nameLabel.text = repo.name
        linguageLabel.text = repo.language
        startsLabel.text = "Stars: \(repo.stargazers_count ?? 0)"
        forksLabel.text = "Forks: \(repo.forks_count ?? 0)"
        descriptionTextView.text = repo.description
        
        containerView.layer.cornerRadius = 5.0
        favoriteButton.isSelected = repo.isFavorite ?? false
    }
    
    
    func setupBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
    }


}
