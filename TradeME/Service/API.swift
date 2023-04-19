//
//  API.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

public protocol RawRepresentable {
    associatedtype RawValue
    init?(rawValue: Self.RawValue)
    var rawValue: Self.RawValue { get }
}

protocol API {
    static var baseUrl: URL { get }
}

enum APIS {
    enum CardPrice: RawRepresentable, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case cardName(name: String)
        case printTag(tag: String)
        case rarityWithTag(rarity: String, tag: String)
        case set(set: String)
        
        var rawValue: String {
            switch self {
            case .cardName(let name): return "get_card_prices/\(name)"
            case .printTag(let tag): return "price_for_print_tag/\(tag)"
            case .rarityWithTag(let rarity, let tag): return "get_card_prices/\(tag)?rarity=\(rarity)"
            case .set(let set): return "get_card_prices/\(set)"
            }
        }
    }
    
    enum CardSet: RawRepresentable, API {
        
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case setName(data: String)
        
        var rawValue: String {
            switch self {
            case .setName(let data): return "set_data/\(data)"
            }
        }
    }
    
    enum CardData: RawRepresentable, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case name(name: String)
        case allKnownV(tag: String)
        case supportCardsByName(name: String)
        
        var rawValue: String {
            switch self {
            case .name(let name): return "card_data/\(name)"
            case .allKnownV(let tag): return "card_versions/\(tag)"
            case .supportCardsByName(let name): return "card_support/\(name)"
                
            }
        }
        
    }
    
    enum CardImage: RawRepresentable, API {
        static let baseUrl = URL(string: "http://yugiohprices.com/api/")!
        case name(name: String)
        case cardSet(set: String)
        
        var rawValue: String {
            switch self {
            case .name(let name): return "card_image/\(name)"
            case .cardSet(let set): return "set_image/\(set)"
            }
        }
    }
}

enum CardDataFetchError: Error {
    case invalidURL
}

extension RawRepresentable where RawValue == String, Self : API {
    init?(rawValue: String) { nil }
    var url: URL {Self.baseUrl.appendingPathComponent(rawValue)}
}
