//
//  Configuration.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

protocol BaseUserListCellViewModel {
    var cellName: String { get }
}

protocol BaseUserListCell {
    func configure(viewModel: BaseUserListCellViewModel)
}
