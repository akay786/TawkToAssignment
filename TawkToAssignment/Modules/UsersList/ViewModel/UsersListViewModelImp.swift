//
//  UsersListViewModelImp.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

class UsersListViewModelImp: UsersListViewModel {
    
    private var users = [User]()
    private var cellViewModels = [BaseUserListCellViewModel]()
    
    private var since = 0
    private var isApiCalled = false
    
    var service: UsersService
    weak var coordinatorDelegate: UsersListViewModelCoordinatorDelegate?
    
    var completionHandler: UsersListViewModelOutputHandler?
    
    
    //MARK: - Initializer
    init(users: [User], service: UsersService) {
        self.service = service
        self.users = users
        self.fetchUsersList()
    }
    
    
    //MARK: - Computed Properties
    var numberOfRows: Int {
        return self.cellViewModels.count
    }
    
    var title: String {
        return AppConstants.Constants.usersList
    }
    
    
    //MARK: - Helper Methods
    func getCellVMAt(index: Int) -> BaseUserListCellViewModel {
        return self.cellViewModels[index]
    }
    
    func fetchUsers() {
        if !self.isApiCalled {
            self.fetchUsersList()
        }
    }
    
    func tappedAtCell(index: Int) {
        self.coordinatorDelegate?.didTapOnUser(user: self.users[index], delegate: self)
    }
    
    func appendCellViewModels(for users: [User]) {
        for user in users {
            let vm = NormalUserListingCellViewModel(userName: user.login ?? "",
                                                    userType: user.type?.rawValue ?? "",
                                                    imageURL: URL(string: user.avatarURL ?? ""))
            self.cellViewModels.append(vm)
        }
        self.completionHandler?(.refreshData)
    }
    
}


//MARK: - Api Call
extension UsersListViewModelImp {
    
    private func fetchUsersList() {
        completionHandler?(.showLoader)
        self.isApiCalled = true
        self.service.getUsersList(since: self.since) { [weak self] result in
            
            guard let `self` = self else {
                return
            }
            
            self.isApiCalled = false
            
            self.completionHandler?(.hideLoader)
            
            switch result {
            
            case .success(let users):
                self.users.append(contentsOf: users)
                self.since = users.last?.id ?? 0
                self.appendCellViewModels(for: users)
                self.completionHandler?(.hideEmptyView)
                
                break
                
            case .failure(_):
                self.completionHandler?(.showEmptyView)
                
            }
            
            self.completionHandler?(.refreshData)
        }
    }
}
