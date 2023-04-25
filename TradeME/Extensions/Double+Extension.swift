//
//  Double+Extension.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation

extension Double {
    func toUSD() -> String {
        self.formatted(.currency(code: "USD"))
    }
}
