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
        if searchText.isEmpty {
            return []
        }
        return cards
     }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults) { result in
                    SearchResultRowView(result: result)
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
//                let card = try await CardFetchViewModel.cardData(for: searchText).data
                let card = try await CardFetchViewModel.cardPrice(for: searchText).data
                card.forEach { card in
                    self.cards.append(SearchResultRowViewModel(result: card, searchText: searchText))
                }
//                self.ygoCards.append(card)
            } catch {
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}
