//
//  API.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

protocol API {
    static var baseUrl: URL { get }
}

enum APIS {
    enum CardPrice: API {
        static let baseUrl = URL(string: "https://api.yelp.comv3")!
        case cardName
        case printTag
        case rarity
        case set
    }
    
    enum CardSet: API {
        static let baseUrl = URL(string: "https://api.yelp.comv3")!
        case setName
    }
    
    enum CardData: API {
        static let baseUrl = URL(string: "https://api.yelp.comv3")!
        case name
        case allKnownV
        case supportCardsByName
    }
    
    enum CardImage: API {
        static let baseUrl = URL(string: "https://api.yelp.comv3")!
        case name
        case cardSet
    }
}
