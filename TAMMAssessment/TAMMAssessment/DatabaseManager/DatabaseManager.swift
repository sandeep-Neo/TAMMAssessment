//
//  DatabaseManager.swift
//  TAMMAssessment
//
//  Created by Capgemini on 03/05/24.
//

import Foundation

import RealmSwift
/// Realm Database Manager class for local DB
class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm?
    
    private init() {
        do {
            realm = try? Realm()
        }
    }
    /// on call will save the data into database
    /// - Parameter data: For specific model type
    func saveData<T:Object>(data: [T]) {
        do {
            try realm?.write {
                realm?.add(data, update: .modified)
            }
        }catch{
            print("An error occurred while saving the data: \(error)")
        }
    }
    
    /// Retrive data from DB
    /// - Parameter obj: For specific model type
    /// - Returns: Return model
    func fetchData<T:Object>(obj:T.Type) -> (data: [T],contains: Bool) {
        var boolValue:Bool = true
        if let obj = realm?.objects(T.self) {
            if obj.isEmpty {
                boolValue =  false
                return (Array(obj) , boolValue)
            }
        }
        
        return ([], boolValue )
    }
    func getDatabaseUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    /// To delete all data from DB
    /// - Parameter obj: For specific model type
    func deleteAll<T:Object>(obj: T.Type) {
        do {
            try realm?.write {
                if let del = realm?.objects(T.self) {
                    realm?.delete(del)
                }
            }
        }catch{
            print("An error occurred while deleting the data: \(error)")
        }
    }
}
