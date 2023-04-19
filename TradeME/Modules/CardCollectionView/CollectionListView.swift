//
//  CollectionListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CollectionListView: View {
    
    @State var collections: [CollectionList]
    
    var body: some View {
        NavigationStack {
            
            List {
                
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Help") {
                    print("Help tapped!")
                }
            }
        }
    }
}

// This page will fetch if you have existing first, then we load it
