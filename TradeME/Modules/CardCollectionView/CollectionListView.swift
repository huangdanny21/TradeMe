//
//  CollectionListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CollectionListView: View {
    let firestoreService = FirestoreService.shared

    @State var collections: [CollectionList]
    @State private var presentAlert = false
    @State private var title: String = ""
    @State private var descrption: String = ""
    @State private var didCreateNewList = false
        
    var body: some View {
        NavigationView {
            List {
                ForEach(collections) { collection in
                    NavigationLink(destination: CardListModificationView(list: collection, cardList: [])) {
                        Text(collection.title)
                    }
                }
            }
            .hiddenNavigationBarStyle()
            .onAppear(perform: {
                fetchCollectionFromFireStore()
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
    
    private func fetchCollectionFromFireStore() {
        // Retrieve the model from Firestore
        
        firestoreService.getDocument(collectionName: FirestoreCollectionName.CardCollection.rawValue, documentId: firestoreService.currentUser?.uid ?? UUID().uuidString) { (result: Result<[CollectionList], Error>) in
            switch result {
            case .success(let myModel):
                print("Retrieved model: \(myModel)")
            case .failure(let error):
                print("Error retrieving model: \(error.localizedDescription)")
            }
        }
    }
    
    private func addNewCollection() {
        presentAlert = true
    }
    
    private func saveNewList() {
        firestoreService.saveDocument(collectionName: FirestoreCollectionName.CardCollection.rawValue, data: collections, documentId: firestoreService.currentUser?.uid ?? "") { result in
            switch result {
            case .success:
                print("Document saved successfully")
            case .failure(let error):
                print("Error saving document: \(error.localizedDescription)")
            }
        }
    }
    
    private func createdNewList() {
        let newList = CollectionList(title: title, descrption: descrption, cards: [])
        collections.append(newList)
        saveNewList()
        didCreateNewList = true
    }
}

// This page will fetch if you have existing first, then we load it
