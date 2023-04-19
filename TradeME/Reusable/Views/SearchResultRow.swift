//
//  SearchResultRow.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchResultRowViewModel: Identifiable  {
    let result: BasicCard
    let searchText: String
    let id = UUID()
}

struct SearchResultRow: View {
    let result: SearchResultRowViewModel
    
    var body: some View {
        HStack {
            WebImage(url: URLMaker.urlForCardName(name: result.searchText))
                .resizable()
                            .frame(width: 60, height: 75)
                            .aspectRatio(contentMode: .fit)
            
            VStack {
                HStack {
                    Text("Series:").foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.leading)
                    Spacer()
                    Text(result.result.name).foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Rarity:").foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.leading)
                    Spacer()
                    Text(result.result.rarity).foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Price:").foregroundColor(.black).font(.system(size: 13)).multilineTextAlignment(.leading)
                    Spacer()
                    let formatted = (result.result.priceData.data?.prices.high ?? 0).formatted(.currency(code: "USD"))
                    Text(formatted).foregroundColor(.red).lineLimit(1).font(.system(size: 13)).multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
