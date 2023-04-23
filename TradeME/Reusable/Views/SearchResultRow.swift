//
//  SearchResultRow.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct SearchResultRowViewModel: Identifiable  {
    let result: BasicCard
    let searchText: String
    let id = UUID()
}

enum SearchResultAccesory {
    case add
    case minusAdd
}

struct SearchResultRow: View {
    let result: SearchResultRowViewModel
    var addCard: ((SearchResultRowViewModel) -> ())?
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(result.result.name).foregroundColor(.black).font(.system(size: 13))
                }
                HStack {
                    Text(result.result.rarity).foregroundColor(.black).font(.system(size: 13))
                }
                HStack {
                    let formatted = (result.result.priceData.data?.prices.high ?? 0).formatted(.currency(code: "USD"))
                    Text(formatted).foregroundColor(.red).lineLimit(1).font(.system(size: 13))
                }
            }
            Spacer()
            HStack {
                Button("+") {
                    
                }.frame(width: 50,height: 50)
            }
        }
    }
}
