//
//  UserDefaultsHelper.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/19/23.
//

import Foundation

struct UserDefaultsHelper {
    static func saveObject<T: Codable>(object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func getObject<T: Codable>(forKey key: String) -> T? {
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(T.self, from: data) {
                return object
            }
        }
        return nil
    }
}
