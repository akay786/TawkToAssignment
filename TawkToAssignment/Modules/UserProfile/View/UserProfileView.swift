//
//  UserProfileView.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import UIKit

class UserProfileView: UIView {

    @IBOutlet weak var userProfileImageOuterView: UIView! {
        didSet {
            userProfileImageOuterView.layer.masksToBounds = false
            userProfileImageOuterView.layer.cornerRadius = 100
        }
    }
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel! {
        didSet {
            userFullNameLabel.textColor = AppConstants.Colors.headingColor
            userFullNameLabel.font = AppConstants.Font.medium(size: 16)
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!  {
        didSet {
            userNameLabel.textColor = AppConstants.Colors.subtitleColor
            userNameLabel.font = AppConstants.Font.medium(size: 14)
        }
    }
    
    @IBOutlet weak var publicReposCount: UILabel! {
        didSet {
            publicReposCount.textColor = AppConstants.Colors.primaryColor
        }
    }
    
    @IBOutlet weak var publicReposLabel: UILabel! {
        didSet {
            publicReposLabel.text = "REPOSITORIES"
        }
    }
    
    @IBOutlet weak var followersCount: UILabel! {
        didSet {
            followersCount.textColor = UIColor.systemYellow
        }
    }
    
    @IBOutlet weak var followersLabel: UILabel! {
        didSet {
            followersLabel.text = "FOLLOWERS"
        }
    }
    
    @IBOutlet weak var followingCount: UILabel! {
        didSet {
            followersCount.textColor = UIColor.systemPurple
        }
    }
    
    @IBOutlet weak var followingLabel: UILabel! {
        didSet {
            followingLabel.text = "FOLLOWING"
        }
    }
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            outerView.layer.cornerRadius = 8
        }
    }
        
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.tintColor = AppConstants.Colors.primaryColor
        }
    }
    
    //MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [publicReposCount, followersCount, followingCount].forEach { label in
            label?.font = AppConstants.Font.medium(size: 30)
        }
        
        [publicReposLabel, followersLabel, followingLabel].forEach { label in
            label?.font = AppConstants.Font.regular(size: 12)
            label?.textColor = AppConstants.Colors.primaryColor
        }
        
    }
    
}
