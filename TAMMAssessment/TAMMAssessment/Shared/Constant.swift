//
//  Constant.swift
//  TAMMAssessment
//
//  Created by Capgemini on 03/05/24.
//

import Foundation
import UIKit
/// Constants class will keep all constant methods and variables
class Constants{
    // MARK: - Web service Urls
    //Base Url
    static var kBaseUrl = "http://universities.hipolabs.com/"
    
    // Webservice Path
    static let kListUrl = "search?country=United%20Arab%20Emirates"
    
    // MARK: -  Popup View
    static let kAlertTitle_MESSAGE = "Message"
    static let kAlertTitle_ERROR = "Error"
    
    // MARK:-  Alert Action
    static let kAlertAction_YES = "Ok"
    static let kAlertAction_CANCEL = "Cancel"
    static let kAlertAction_NO = "No"
    
    // MARK: -   StoryBoard
    static let kMainStoryboard = "Main"
    
    // MARK:- View Controllers
    static let kUniversityListVC = "UniversityListVC"
    static let kUniversityDetailVC = "UniversityDetailVC"
    
    // MARK: - UIStoryboard and push controller genric method
    
    static func getViewController<T: UIViewController>(storyboard: String, identifier: String, type: T.Type) -> T {
        return Constants.getViewController(storyboard: storyboard, identifier: identifier) as? T ?? T()
    }
    
    static func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let storyboard = Constants.storyboard(storyboardID: storyboard)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    private static func storyboard(storyboardID: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardID, bundle: Bundle.main)
        return storyboard
    }
}
