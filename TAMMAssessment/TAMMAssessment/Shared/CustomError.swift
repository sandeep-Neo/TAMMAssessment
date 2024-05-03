//
//  CustomError.swift
//  TAMMAssessment
//
//  Created by Capgemini on 03/05/24.
//

import Foundation
enum CustomError:Error {
    case NoNetwork //1009
    case HTTPError(err:Error)
    case ServerError
    case TimeOut //2102
    case ParsingError
    case BadRequest
    case NoDataFound
    
    var localizedDescription: String {
        switch  self {
        case .NoNetwork:
            return "No Network"
        case .HTTPError(let error):
            return "\(error.localizedDescription)"
        case .TimeOut:
            return "The request has timed out"
        case .ParsingError:
            return "Unable to Serialize"
        case .BadRequest:
            return "Something went wrong"
        case .NoDataFound:
            return "No Data Found"
            
        default:
            return ""
        }
    }
}
