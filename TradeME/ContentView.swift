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
                     Text("Send Me").padding().background(Color.green)
                     

                 }
            }
            .padding()
        }
        .onAppear {
            
        }
    }
    
    
    func fetch() {
        // Start an async task
        Task {
            do {
                let card = try await CardFetchViewModel.cardPrice(for: "Kuriboh")
            } catch {
                print("Request failed with error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
