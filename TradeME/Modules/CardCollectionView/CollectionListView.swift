//
//  CollectionListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CollectionListView: View {
    
//    @State var collections: [CollectionList]
    @State private var presentAlert = false
    @State private var title: String = ""
    @State private var descrption: String = ""
    @State private var didCreateNewList = false
    
    @State var cardCollectionList: [CollectionListHashable]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cardCollectionList) { collection in
                    NavigationLink(destination: CardListModificationView(cardList: [], collectionList: collection)) {
                        Text(collection.key)
                    }
                }
            }
            .hiddenNavigationBarStyle()
            .onAppear(perform: {
                fetchSavedCollections()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addNewCollection()
                    }
                    .alert("New List", isPresented: $presentAlert, actions: {
                        TextField("Title", text: $title)
                        TextField("descrption", text: $descrption)

                        Button("Create", role: .destructive, action: { createdNewList()})
                        Button("Cancel", role: .cancel, action: {})
                    }, message: {
                        Text("Enter title and description if needed")
                    })
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func fetchSavedCollections() {
        let userDefaults = UserDefaults.standard
        do {
            let previousCardCollectionList = try userDefaults.getObject(forKey: Constants.CardCollection.savedCollection.rawValue, castTo: [CollectionListHashable].self)
            
            cardCollectionList = previousCardCollectionList
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addNewCollection() {
        presentAlert = true
    }
    
    private func createdNewList() {
        let newList = CollectionList(title: title, descrption: descrption, cards: [])
        let newCollection = CollectionListHashable(key: title, collection: newList)
        cardCollectionList.append(newCollection)

        let userDefaults = UserDefaults.standard

        do {
             try userDefaults.setObject(cardCollectionList, forKey: Constants.CardCollection.savedCollection.rawValue)

        } catch {
            print(error.localizedDescription)
        }
        didCreateNewList = true
    }
}

// This page will fetch if you have existing first, then we load it
