//
//  FSUser.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation

struct FSUser: Identifiable, Codable {
    var id: String
    var firstName: String?
    var lastName: String?
    var email: String
    var konamiId: String?
    var userName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case konamiId
        case userName
    }
    
    init(id: String, firstName: String? = nil, lastName: String? = nil, email: String, konamiId: String? = nil, userName: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.konamiId = konamiId
        self.userName = userName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        konamiId = try values.decode(String.self, forKey: .konamiId)
        userName = try values.decode(String.self, forKey: .userName)
        email = try values.decode(String.self, forKey: .email)
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "first_name": firstName ?? "",
            "last_name": lastName ?? "",
            "email": email,
            "konamiId": konamiId ?? "",
            "userName": userName ?? ""
        ]
    }
}
