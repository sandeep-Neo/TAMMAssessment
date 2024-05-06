//
//  NetworkManager.swift
//  TAMMAssessment
//
//  Created by Capgemini on 03/05/24.
//

import Foundation
/// Common Network class for API call
class NetworkManager {
    
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func getRequest<T: Decodable>(type: T.Type, url: URL, completion: @escaping(Result<T, CustomError>) -> Void) {
        
        aPIHandler.getData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

protocol APIHandlerDelegate {
    func getData(url: URL, completion: @escaping(Result<Data, CustomError>) -> Void)
}

class APIHandler: APIHandlerDelegate {
    func getData(url: URL, completion: @escaping(Result<Data, CustomError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if NetworkConnection().isConnectedToNetwork() == false {
                    return completion(.failure(.NoNetwork))
                }
                return completion(.failure(.NoDataFound))
            }
            completion(.success(data))
        }.resume()
    }
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Decodable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Decodable>(type: T.Type, data: Data, completion: (Result<T, CustomError>) -> Void) {
        let commentResponse = try? JSONDecoder().decode(type.self, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.ParsingError))
        }
    }
}
