//
//  UsersListingView.swift
//  TawkToAssignment
//
//  Created by VenD on 05/10/2021.
//

import UIKit

class UsersListingView: UIView {

    @IBOutlet weak var searchView: SearchBar!
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.separatorColor = .clear
        }
    }
    
    @IBOutlet weak var emptyListView: UIView! {
        didSet {
            emptyListView.isHidden = true
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = AppConstants.Colors.primaryColor
        }
    }
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            outerView.backgroundColor = AppConstants.Colors.appBackgroundColor
        }
    }
        
    @IBOutlet weak var emptyViewTitleLabel: UILabel! {
        didSet {
            emptyViewTitleLabel.textColor = AppConstants.Colors.headingColor
            emptyViewTitleLabel.font = AppConstants.Font.medium(size: 16)
        }
    }

}
