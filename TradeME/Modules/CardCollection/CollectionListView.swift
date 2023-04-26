//
//  CollectionListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CollectionListView: View {
    let firestoreService = FirestoreService.shared
    
    @State var collections: [FSCollectionList]
    @State private var presentAlert = false
    @State private var title: String = ""
    @State private var descrption: String = ""
    @State private var didCreateNewList = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(collections, id: \.id) { collection in
                    NavigationLink(destination: CardListModificationView(list: collection, cardList: [])) {
                        Text(collection.title)
                    }
                }
            }
            .onAppear(perform: {
                fetchCollectionFromFirestore()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("+") {
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
            .navigationTitle("Collections")
        }
    }
    
    // MARK: - Private
    
    private func fetchCollectionFromFirestore() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: current user not found")
            return
        }
        
        let db = Firestore.firestore()
        db.collection(FirestoreCollectionName.CardCollection.rawValue).document("\(uid)").getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    print("Fetched data: \( document.data() )")
                    
                    let collectionList = try document.data(as: FSCollectionListContainer.self).collections
                    self.collections = collectionList
                } catch {
                    print("Error decoding collection list: \(error)")
                }
            } else {
                print("Collection list not found")
            }
        }
    }
    
    private func addNewCollection() {
        presentAlert = true
    }
    
    private func createdNewList() {
        let newList = FSCollectionList(title: title, description: descrption, cards: [])
        
        collections.append(newList)
        
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid ?? UUID().uuidString
        let docRef = db.collection(FirestoreCollectionName.CardCollection.rawValue).document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Collection already exists, update it
                docRef.updateData([
                    "collections": FieldValue.arrayUnion([newList.toDict()])
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document updated")
                    }
                }
            } else {
                // Collection doesn't exist, create it
                let data: [String: Any] = [
                    "userId": userId,
                    "collections": [newList.toDict()]
                ]
                docRef.setData(data) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added")
                    }
                }
            }
        }
        
        title = ""
        descrption = ""
        didCreateNewList = true
    }
}
