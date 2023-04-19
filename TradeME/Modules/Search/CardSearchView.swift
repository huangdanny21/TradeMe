//
//  CardSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CardSearchView: View {
    
    @State var cards = [SearchResultRowViewModel]()
    @State var ygoCards = [YGOCard]()
    @State var searchText = ""
    
    var searchResults: [SearchResultRowViewModel] {
        searchText.isEmpty ? [] : cards
     }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { result in
                    SearchResultRow(result: result)
                }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search, fetch)
    }
    
    // MARK: - Private
    
    func fetch() {
        Task {
            do {
                let card = try await CardFetchService.cardPrice(for: searchText).data
                card.forEach { card in
                    self.cards.append(SearchResultRowViewModel(result: card, searchText: searchText))
                }
            } catch {
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}
