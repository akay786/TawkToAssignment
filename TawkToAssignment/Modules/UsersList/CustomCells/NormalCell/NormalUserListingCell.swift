//
//  NormalUserListingCell.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import UIKit

class NormalUserListingCell: UITableViewCell, BaseUserListCell {
    
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
    

    
    //MARK: - ViewModel Configuration
    func configure(viewModel: BaseUserListCellViewModel) {
        guard let vm = viewModel as? NormalUserListingCellViewModel else {
            return
        }
        
        self.userNameLabel.text = vm.userName
        self.userType.text = vm.userType
        DispatchQueue.global(qos: .userInteractive).async {
            if let imageUrl = vm.url {
                self.userImageView.downloadImage(from: imageUrl)
            }
        }
    }
    
}
