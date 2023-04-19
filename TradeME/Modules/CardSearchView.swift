//
//  CardSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct CardSearchView: View {
    
    @State var cards = [BasicCard]()
    @State var cardNames = [String]()

    @State var searchText = ""
    
    var searchResults: [String] {
        searchText.isEmpty ? cardNames : cards.map{$0.name}
     }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
        }
        .hiddenNavigationBarStyle()
        .searchable(text: $searchText)
        
        .onSubmit(of: .search, fetch)
    }
    
    // MARK: - Private
    
    func fetch() {
        Task {
            do {
                let card = try await CardFetchViewModel.cardPrice(for: searchText).data
                self.cards = card
                self.cardNames = card.map{$0.name}
            } catch {
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}
