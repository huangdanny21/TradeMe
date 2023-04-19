//
//  ContentView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Card Price") {
                fetch()
            }
        }
        .padding()
        .onAppear {
            
        }
    }
    
    
    func fetch() {
        // Start an async task
        Task {
            do {
                let card = try await CardFetchViewModel.cardPrice(for: "Kuriboh")
                print(card)
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
