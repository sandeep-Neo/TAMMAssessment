//
//  UniversityListProtocols.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: AnyObject{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingData()
    func showViewController(navigationController: UINavigationController, with data: UniversityListModel)
}

protocol PresenterToViewProtocol: AnyObject{
    func showList(data: [UniversityListModel])
    func showError(error:CustomError)
}

protocol PresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func pushToViewController(navigationConroller: UINavigationController, with data: UniversityListModel)
    var presenter: RouterToPresenterProtocol? {get set}
}

protocol PresenterToInteractorProtocol: AnyObject {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchData()
}

protocol InteractorToPresenterProtocol: AnyObject {
    func fetchedSuccess(data: [UniversityListModel])
    func fetchFailed(error:CustomError)
}

protocol RouterToPresenterProtocol: AnyObject {
    func refreshData()
}
