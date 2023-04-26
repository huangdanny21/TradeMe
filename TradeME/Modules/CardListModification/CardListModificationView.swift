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
    
    @State var list: FSCollectionList
    @State var showingPopup = false
    
    @State var cardList: [CardContainer]
    @State private var editMode = EditMode.inactive
    @Environment(\.presentationMode) var presentationMode

    
    var total: Double {
        var total: Double = 0
        cardList.forEach { container in
            total += container.total
        }
        return total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("List Title")) {
                    if editMode == .active {
                        TextField("Enter title", text: $list.title)
                    } else {
                        Text(list.title)
                            .onTapGesture {
                                editMode = .active
                            }
                    }
                }
                
                Section(header: Text("Cards")) {
                    List {
                        ForEach(cardList) { cardContainer in
                            CardModificationView(card: cardContainer)
                        }
                        .onDelete(perform: deleteCard)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text("Total: \(total.formatted(.currency(code: "USD")))").font(.headline)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if editMode == .active {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            editMode = .inactive
                            save()
                        }) {
                            Text("Done")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editMode == .inactive {
                        Button(action: {
                            editMode = .active
                        }) {
                            Text("Edit")
                        }
                    } else {
                        EditButton()
                    }
                }
            }
        }
//        .navigationBarItems(leading:
//            Button(action: {
//                presentationMode.wrappedValue.dismiss()
//            }, label: {
//                Image(systemName: "chevron.backward")
//            })
//        )
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
        // Save changes to the list and cardList
    }
    
    func deleteCard(at offsets: IndexSet) {
        cardList.remove(atOffsets: offsets)
    }
}
