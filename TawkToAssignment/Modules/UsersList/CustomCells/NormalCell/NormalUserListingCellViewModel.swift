//
//  NormalUserListingCellViewModel.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

class NormalUserListingCellViewModel: BaseUserListCellViewModel {
   
    var cellName: String = NormalUserListingCell.reuseIdentifier
    
    var profileSeen: Bool
    var userName: String
    var userType: String
    var url: URL?
    
    init(userName: String, userType: String, imageURL: URL?, profileSeen: Bool) {
        self.userName = userName
        self.userType = userType
        self.url = imageURL
        self.profileSeen = profileSeen
    }
}
