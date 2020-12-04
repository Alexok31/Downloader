//
//  File.swift
//  Downloader
//
//  Created by Alex Kharchenko on 30.11.2020.
//

import Realm
import RealmSwift

typealias TopPagesEntity = [TopPageEntity]

class TopPageEntity: Object, Codable {
    
    @objc dynamic var name: String? = nil
    @objc dynamic var link: String? = nil
    @objc dynamic var icon: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case link = "link"
        case icon = "icon"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try? container.decode(String.self, forKey: .name)
        link = try? container.decode(String.self, forKey: .link)
        icon = try? container.decode(String.self, forKey: .icon)
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
