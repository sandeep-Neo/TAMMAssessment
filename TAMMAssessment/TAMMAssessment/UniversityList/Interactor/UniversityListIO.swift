//
//  UniversityListIO.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import Foundation
import RealmSwift

class UniversityListIO: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    /// Method will make the Network call using URLSession and will save the data into local database using Realm
    func fetchData() {
        guard let url = URL(string: Constants.kBaseUrl+Constants.kListUrl) else {
            return
        }
        NetworkManager().getRequest(type:[UniversityListModel].self , url: url) { [weak self] result in
            guard let ws = self else {return}
            DispatchQueue.main.async{
                switch result{
                case .success(let dataValue):
                    if dataValue.count == 0 {
                        if RealmManager.shared.fetchData(obj: UniversityListModel.self).contains {
                            ws.presenter?.fetchedSuccess(data: RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                        } else {
                            ws.presenter?.fetchFailed(error: CustomError.NoDataFound)
                        }
                    } else {
                        RealmManager.shared.deleteAll(obj: UniversityListModel.self)
                        RealmManager.shared.saveData(data: dataValue)
                        ws.presenter?.fetchedSuccess(data: RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                    }
                case .failure(_):
                    if !RealmManager.shared.fetchData(obj: UniversityListModel.self).contains {
                        self?.presenter?.fetchFailed(error: CustomError.NoDataFound)
                    }
                    self?.presenter?.fetchedSuccess(data:RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                }
            }
        }
        
    }
}

