//
//  CollectionListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CollectionListView: View {
    
    @State var collections: [CollectionList]
    @State private var presentAlert = false
    @State private var title: String = ""
    @State private var descrption: String = ""
    @State private var didCreateNewList = false
    
    var body: some View {
        List {
            ForEach(collections) { collection in
                NavigationLink(destination: CardListModificationView(list: collection, cardList: [])) {
                    Text(collection.title)
                }
            }
        }
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
    
    // MARK: - Private
    
    private func addNewCollection() {
        presentAlert = true
    }
    
    private func createdNewList() {
        let newList = CollectionList(title: title, descrption: descrption, cards: [])
        collections.append(newList)
        didCreateNewList = true
    }
}

// This page will fetch if you have existing first, then we load it
