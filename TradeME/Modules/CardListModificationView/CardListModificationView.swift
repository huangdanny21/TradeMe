//
//  CardListModificationView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import PopupView

struct CardListModificationView: View {
    
    @State var list: CollectionList
    @State var showingPopup = false
        
    @State var cardList: [BasicCard]
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add card") {
                    showingPopup = true
                }
                List {
                    ForEach(cardList, id: \.id) { list in
                        SearchResultRow(result: SearchResultRowViewModel(result: list, searchText: ""))
                    }
                }
            }
            
        }
        .popup(isPresented: $showingPopup) {
            CardSearchView(addCard: addCard(with:))
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .position(.bottom)
                .closeOnTap(false)
            .dragToDismiss(true)
        
        }
    }
    
    // MARK: - Private
    
    func addCard(with card: SearchResultRowViewModel) {
        cardList.append(card.result)
    }
}
