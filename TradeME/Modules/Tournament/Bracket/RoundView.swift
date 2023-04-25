//
//  RoundView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI

struct RoundView: View {
    let round: Round
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Round \(round.number)")
                .font(.title)
            
            ForEach(round.matches) { match in
                HStack {
                    Text(match.player1)
                    Spacer()
                    Text(match.result ?? "-")
                    Spacer()
                    Text(match.player2)
                }
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(10)
    }
}
