//
//  Router.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import Foundation
import UIKit

class Router: PresenterToRouterProtocol {
    
    weak var presenter: RouterToPresenterProtocol?
    
    /// Method will create UniversityListVC and will initialize all the dependency in it.
    /// - Returns: will return UIViewController type.
    static func createModule() -> UIViewController {
        let view = Constants.getViewController(storyboard: Constants.kMainStoryboard, identifier: Constants.kUniversityListVC, type: UniversityListVC.self)
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol & RouterToPresenterProtocol = UniversityListPresenter()
        let interactor: PresenterToInteractorProtocol = UniversityListIO()
        let router: PresenterToRouterProtocol = Router()
        
        view.presentor = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
    
    /// Method will redirect to the screen with data.
    /// - Parameters:
    ///   - navigationConroller: UINavigationController required.
    ///   - data: UniversityListModel required.
    func pushToViewController(navigationConroller: UINavigationController, with data: UniversityListModel) {
        let vc = Constants.getViewController(storyboard: Constants.kMainStoryboard, identifier: Constants.kUniversityDetailVC, type: UniversityDetailVC.self)
        vc.universityData = data
        vc.delegate = self
        navigationConroller.pushViewController(vc, animated: true)
    }
}

extension Router: UniversityDetailProtocol {
    /// Method will send a request to Presenter layer to refresh the data.
    func refreshListScreen() {
        self.presenter?.refreshData()
    }
}
