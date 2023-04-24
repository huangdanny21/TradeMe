//
//  CardListModificationView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import PopupView

struct CardContainer: Identifiable {
    var id =  UUID().uuidString
    
    var name: String
    var count: Int
    var card: BasicCard
    
    var total: Double {
        Double(count) *  (card.priceData.data?.prices.average ?? 0)
    }
    
    var totalString: String {
        total.formatted(.currency(code: "USD"))
    }
}

struct CardListModificationView: View {
    
    @State var list: CollectionList
    @State var showingPopup = false
    
    @State var cardList: [CardContainer]
    
    var total: Double {
        var total: Double = 0
        cardList.forEach { container in
            total += container.total
        }
        return total
    }
    
    var totalString: String {
        total.formatted(.currency(code: "USD"))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add card") {
                    showingPopup = true
                }
                
                List {
                    ForEach(cardList, id: \.card.id) { list in
                        CardModificationView(card: list)
                    }
                }
                Text("Total: \(total.formatted(.currency(code: "USD")))")
            }
            .toolbar {
                Button("Save") {
                    save()
                }
            }
        }
        .hiddenNavigationBarStyle()
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
        cardList.append(CardContainer(name: card.searchText, count: 1, card: card.result))
    }
    
    func save() {
//        let userDefaults = UserDefaults.standard
//        do {
//            var previousCollection = try userDefaults.getObject(forKey: Constants.CardCollection.savedCollection.rawValue, castTo: [CollectionList].self)
//            previousCollection.append(<#T##newElement: CollectionList##CollectionList#>)
//        } catch {
//            print(error.localizedDescription)
//        }
//        userDefaults.set(CollectionList.self, forKey: Constants.CardCollection.newCollection.rawValue)
    }
}
