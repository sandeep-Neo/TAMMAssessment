//
//  UniversityListModel.swift
//  TAMMAssessment
//
//  Created by Capgemini on 02/05/24.
//

import Foundation
import RealmSwift
import Realm
/// Properties
class UniversityListModel : Object, Decodable {
    @Persisted var domains = RealmSwift.List<String>()
    @Persisted var id : ObjectId = ObjectId.generate()
    @Persisted var stateProvince : String = ""
    @Persisted var name : String = ""
    @Persisted var web_pages = RealmSwift.List<String>()
    @Persisted var country : String = ""
    @Persisted var alpha_two_code : String = ""
    
    enum CodingKeys: String, CodingKey {
        
        case domains = "domains"
        case stateProvince = "state-province"
        case name = "name"
        case web_pages = "web_pages"
        case country = "country"
        case alpha_two_code = "alpha_two_code"
        case id = "id"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        domains = try values.decodeIfPresent(List<String>.self, forKey: .domains) ?? List<String>()
        stateProvince = try values.decodeIfPresent(String.self, forKey: .stateProvince) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        web_pages = try values.decodeIfPresent(List<String>.self, forKey: .web_pages) ?? List<String>()
        country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        alpha_two_code = try values.decodeIfPresent(String.self, forKey: .alpha_two_code) ?? ""
        super.init()
    }
    
    required override init()
    {
        super.init()
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
}

