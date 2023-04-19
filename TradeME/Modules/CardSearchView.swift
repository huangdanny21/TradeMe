//
//  CardSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct CardSearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
                .navigationTitle("Searchable Example")
        }
        .searchable(text: $searchText, prompt: "Look for something")
    }
}
