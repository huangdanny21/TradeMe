//
//  URLMaker.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct URLMaker {
    static func urlForCardName(name: String) -> URL {
        APIS.CardImage.name(name: name).url
    }
}
