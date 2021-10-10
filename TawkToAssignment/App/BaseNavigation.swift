//
//  BaseNavigation.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        navigationBar.barTintColor = AppConstants.Colors.primaryColor
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: AppConstants.Font.medium(size: 18)
        ]
    }
}
