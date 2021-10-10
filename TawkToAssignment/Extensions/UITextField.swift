//
//  UITextField.swift
//  TvShowManager
//
//  Created by Awais on 13/09/2021.
//

import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

enum GradientDirection {
    case vertical
    case horizontal
    case diagonal
    
    var start: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    
    var end: CGPoint {
        switch self {
        case .vertical: return CGPoint(x: 0, y: 1)
        case .horizontal: return CGPoint(x: 1, y: 0)
        case .diagonal: return CGPoint(x: 1, y: 1)
        }
    }
}


