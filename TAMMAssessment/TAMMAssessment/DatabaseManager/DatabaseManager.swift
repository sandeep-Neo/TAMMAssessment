//
//  DatabaseManager.swift
//  TAMMAssessment
//
//  Created by Capgemini on 03/05/24.
//

import Foundation

import RealmSwift
class RealmManager {
    static let shared = RealmManager()
    private let realm: Realm
    private init() {
        realm = try! Realm()
    }
    func saveData<T:Object>(data: [T]) {
        try! realm.write {
            realm.add(data, update: .modified)
        }
    }
    func fetchData<T:Object>(obj:T.Type) -> (data: [T],contains: Bool) {
        var boolValue:Bool = true
        if realm.objects(T.self).isEmpty {
            boolValue =  false
        }
        return (Array(realm.objects(T.self)), boolValue )
    }
    func getDatabaseUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    func deleteAll<T:Object>(obj: T.Type) {
        try! realm.write {
            realm.delete( realm.objects(T.self))
        }
    }
}
