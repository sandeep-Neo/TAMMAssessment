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
    private let urlStr: String = "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates"
    
    /// Method will make the Network call using URLSession and will save the data into local database using Realm
    func fetchData() {
        let url: URL = URL(string: urlStr) ?? URL(fileURLWithPath: "")
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                if !RealmManager.shared.fetchData(obj: UniversityListModel.self).contains {
                    self?.presenter?.fetchFailed()
                }
                self?.presenter?.fetchedSuccess(data:RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                
                return
            }
            
            DispatchQueue.main.async {
                if let jsonData = try? JSONDecoder().decode([UniversityListModel].self, from: data){
                    if jsonData.count == 0 {
                        if RealmManager.shared.fetchData(obj: UniversityListModel.self).contains {
                            self.presenter?.fetchedSuccess(data: RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                        } else {
                            self.presenter?.fetchFailed()
                        }
                    } else {
                        RealmManager.shared.deleteAll(obj: UniversityListModel.self)
                        RealmManager.shared.saveData(data: jsonData)
                        self.presenter?.fetchedSuccess(data: RealmManager.shared.fetchData(obj: UniversityListModel.self).data)
                    }
                   
                    
                }
            }
            
        }.resume()
    }
}

