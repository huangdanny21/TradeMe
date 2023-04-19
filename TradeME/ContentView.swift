//
//  ContentView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CardSearchView()) {
                    Text("To Search").padding().background(.black)
                 }
                NavigationLink(destination: CollectionListView(collections: [])) {
                     Text("My Collections").padding().background(Color.red)
                 }
            }
            .padding()
        }
        .onAppear {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
