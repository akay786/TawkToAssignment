//
//  UserProfileViewController.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import UIKit

class UserProfileViewController: UIViewController {

    var viewModel: UserProfileViewModel?
    
    
    //MARK: - Outlets
    @IBOutlet var userProfileView: UserProfileView!
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModel()
        
        self.view.backgroundColor = AppConstants.Colors.outerViewColor
    }
    

}

//MARK: - ViewModel Binding
extension UserProfileViewController {
    
    private func bindViewModel() {
        self.viewModel?.completionHandler = { [weak self] output in
            switch output {
            case .hideLoader:
                DispatchQueue.main.async {
                    self?.userProfileView.activityIndicator.stopAnimating()
                }
                
                
            case .showLoader:
                DispatchQueue.main.async {
                    self?.userProfileView.activityIndicator.startAnimating()
                }
                
            case .updateProfile:
                DispatchQueue.main.async {
                    self?.initializeData()
                }
                break
            
            }
        }
    }
    
    
    private func initializeData() {
        guard let vM = self.viewModel,
              let profileDetail = vM.userProfile else {
            return
        }
        
        if profileDetail.name?.isEmpty ?? true {
            self.userProfileView.userFullNameLabel.isHidden = true
        }
        
        self.userProfileView.userFullNameLabel.text = profileDetail.name
        self.userProfileView.userNameLabel.text = profileDetail.login
        self.userProfileView.publicReposCount.text = "\(profileDetail.publicRepos ?? 0)"
        self.userProfileView.followingCount.text = "\(profileDetail.following ?? 0)"
        self.userProfileView.followersCount.text = "\(profileDetail.followers ?? 0)"
        
        DispatchQueue.global(qos: .userInteractive).async {
            if let avatarUrl = profileDetail.avatarURL, let imageUrl = URL(string: avatarUrl) {
                self.userProfileView.userProfileImage.downloadImage(from: imageUrl)
            }
        }
    }
    
}
