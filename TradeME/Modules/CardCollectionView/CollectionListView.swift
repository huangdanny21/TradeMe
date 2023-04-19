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
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        NavigationStack {
            
            List {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    addNewCollection()
                }
                .alert("New List", isPresented: $presentAlert, actions: {
                    TextField("Title", text: $username)
                    TextField("descrption", text: $username)
                    
                    Button("Create", action: { didCreateNewList()})
                    Button("Cancel", role: .cancel, action: { didNotcreateNewList()})
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
    
    private func didNotcreateNewList() {
        print("Did not create list")
    }
    
    private func didCreateNewList() {
        print("Did  create list")
    }
}

// This page will fetch if you have existing first, then we load it
