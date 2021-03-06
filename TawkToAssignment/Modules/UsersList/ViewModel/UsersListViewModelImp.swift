//
//  UsersListViewModelImp.swift
//  TawkToAssignment
//
//  Created by VenD on 10/10/2021.
//

import Foundation

class UsersListViewModelImp: UsersListViewModel {
    
    private var users = [User]()
    private var searchedUsers = [User]()
    private var isSearching = false
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
        self.since = UserDefaultsManager.shared.getSinceValue()
        self.fetchSavedUserList()
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
        if !self.isApiCalled && !self.isSearching {
            ///If internet is connected then fetch list
            if Reachability.isConnectedToNetwork() {
                self.fetchUsersList()
            }
        }
    }
    
    func tappedAtCell(index: Int) {
        let user = self.users[index]
        self.service.setStatusToSeenFor(userName: user.login ?? "") { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.coordinatorDelegate?.didTapOnUser(user: user, delegate: weakSelf)
        }
        
    }
    
    func appendCellViewModels(for users: [User]) {
        var count = 0
        for user in users {
            count = count + 1
            
            let viewModel: BaseUserListCellViewModel
            
            if count % 4 == 0 {
                viewModel = InvertedUserListingCellViewModel(userName: user.login ?? "",
                                                             userType: user.type ?? "",
                                                             imageURL: URL(string: user.avatarURL ?? ""),
                                                             profileSeen: user.isSeen,
                                                             notesAdded: user.isNotesAdded)
                
            } else {
                if user.isNotesAdded {
                    viewModel = NoteUserListingCellViewModel(userName: user.login ?? "",
                                                             userType: user.type ?? "",
                                                             imageURL: URL(string: user.avatarURL ?? ""),
                                                             profileSeen: user.isSeen)
                } else {
                    viewModel = NormalUserListingCellViewModel(userName: user.login ?? "",
                                                               userType: user.type ?? "",
                                                               imageURL: URL(string: user.avatarURL ?? ""),
                                                               profileSeen: user.isSeen)
                }
            }
            
            self.cellViewModels.append(viewModel)
        }
        
        self.completionHandler?(.refreshData)
    }
    
    func searchUser(text: String) {
        self.cellViewModels = []
        self.isSearching = !text.isEmpty
        if text.isEmpty {
            self.appendCellViewModels(for: self.users)
            
        } else {
            self.searchedUsers = []
            let list = self.users.filter({ $0.login?.contains(text) ?? false })
            self.searchedUsers.append(contentsOf: list)
            self.appendCellViewModels(for: self.searchedUsers)
        }
    }
    
}


//MARK: - Api Call
extension UsersListViewModelImp {
    
    private func refreshData(_ users: [User]) {
        self.users.append(contentsOf: users)
        self.appendCellViewModels(for: users)
    }
 
    private func fetchSavedUserList() {
        self.service.fetchLocalUserList { [weak self] users in
            self?.refreshData(users ?? [])
        }
    }
    
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
                self.completionHandler?(.hideEmptyView)
                self.since = Int(users.last?.id ?? 0)
                UserDefaultsManager.shared.saveLastSinceValue(self.since)
                self.refreshData(users)
                
                break

            case .failure(_):
                if self.users.count == 0 {
                    self.completionHandler?(.showEmptyView)
                    self.completionHandler?(.refreshData)
                }
            }
        }
    }
    
    
}
