//
//  InvertedUserListingCell.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import UIKit

class InvertedUserListingCell: UITableViewCell, BaseUserListCell {

    //MARK: - Outlets
    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.textColor = AppConstants.Colors.headingColor
            userNameLabel.font = AppConstants.Font.medium(size: 14)
        }
    }
    
    @IBOutlet weak var userType: UILabel! {
        didSet {
            userType.textColor = AppConstants.Colors.subtitleColor
            userType.font = AppConstants.Font.medium(size: 12)
        }
    }
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            outerView.addShadowsOnly(offset: CGSize(width: 0, height: 0), color: UIColor.black, radius: 4, opacity: 0.20)
        }
    }
    
    @IBOutlet weak var notesIcon: UIImageView!
    
    
    //MARK: - ViewModel Configuration
    func configure(viewModel: BaseUserListCellViewModel) {
        guard let vm = viewModel as? InvertedUserListingCellViewModel else {
            return
        }
        
        self.userNameLabel.text = vm.userName
        self.userType.text = vm.userType
        if vm.profileSeen {
            self.outerView.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        } else {
            self.outerView.backgroundColor = UIColor.white
        }
        
        notesIcon.isHidden = !vm.isNotesAdded
        
        DispatchQueue.global(qos: .userInteractive).async {
            if let imageUrl = vm.url {
                self.userImageView.downloadImage(from: imageUrl)
            }
        }
        
    }
}
