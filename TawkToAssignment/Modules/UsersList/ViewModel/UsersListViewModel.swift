//
//  UsersListViewModel.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

typealias UsersListViewModelOutputHandler = (UsersListViewModelOutput) -> ()

protocol UsersListViewModelCoordinatorDelegate : class {
    func didTapOnUser(user: User, delegate: UsersListViewModelImp)
}

protocol UsersListViewModel {
    
    var service : UsersService { get }
    var coordinatorDelegate : UsersListViewModelCoordinatorDelegate? { get set }
    
    var title: String { get }
    var completionHandler: UsersListViewModelOutputHandler? { get set }
    var numberOfRows: Int { get }
    
    func getCellVMAt(index: Int) -> BaseUserListCellViewModel
    func fetchUsers() 
    func tappedAtCell(index: Int)
}

enum UsersListViewModelOutput {
    case showLoader
    case hideLoader
    case refreshData
    case showEmptyView
    case hideEmptyView
}
