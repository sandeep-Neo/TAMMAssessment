//
//  UniversityListPresenter.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import Foundation
import UIKit

class UniversityListPresenter: ViewToPresenterProtocol {
    
    var view: (any PresenterToViewProtocol)?
    var interactor: (any PresenterToInteractorProtocol)?
    var router: (any PresenterToRouterProtocol)?
    
    /// Method will send request to Interactor layer to start fetching data.
    func startFetchingData() {
        self.interactor?.fetchData()
    }
    
    /// Method will send request to router layer to navigate to the next screen with data.
    /// - Parameters:
    ///   - navigationController: UINavigationController required.
    ///   - data: UniversityListModel required
    func showViewController(navigationController: UINavigationController, with data: UniversityListModel) {
        router?.pushToViewController(navigationConroller: navigationController, with: data)
    }
}

extension UniversityListPresenter: InteractorToPresenterProtocol {
    /// On Success method will receive the data from Interactor layer and will be sent to the View layer
    /// - Parameter data: UniversityListModel array.
    func fetchedSuccess(data: [UniversityListModel]) {
        view?.showList(data: data)
    }
    
    /// On failure method will receive the notification from Interactor layer and will be sent to the View layer.
    func fetchFailed(error: CustomError) {
        view?.showError(error: error)
    }
}

extension UniversityListPresenter: RouterToPresenterProtocol {
    /// Method will receive request from Router layer from make the API call.
    func refreshData() {
        self.interactor?.fetchData()
    }
}
