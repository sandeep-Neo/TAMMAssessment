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
    static let kAlertTitle_MESSAGE = "MESSAGE"
    static let kAlertTitle_ERROR = "ERROR"


    // MARK:-  Alert Action
    static let kAlertAction_YES = "YES"
    static let kAlertAction_CANCEL = "CANCEL"
    static let kAlertAction_NO = "NO"
    
    // MARK: -   StoryBoard
    static let kMainStoryboard = "Main"
    
    // MARK:- View Controllers
    static let kUniversityListVC = "UniversityListVC"
    static let kUniversityDetailVC = "UniversityDetailVC"
    
    // MARK: - UIStoryboard and push controller genric method
    
    static func getViewController<T: UIViewController>(storyboard: String, identifier: String, type: T.Type) -> T {
        return Constants.getViewController(storyboard: storyboard, identifier: identifier) as! T
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
