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
    enum CardPrice: String, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case cardName = "get_card_prices/%@"
        case printTag = "price_for_print_tag/%@"
        case rarity = "price_history/%@?rarity=%@"
        case set = "set_data/%@"
    }
    
    enum CardSet: String, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case setName = "set_data/%@"
    }
    
    enum CardData: String, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case name = "card_data/%@"
        case allKnownV = "card_versions/%@"
        case supportCardsByName = "card_support/%@"
    }
    
    enum CardImage: String, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case name = "card_image/%@"
        case cardSet = "set_image/%@"
    }
}
