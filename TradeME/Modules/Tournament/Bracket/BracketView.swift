//
//  BracketView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI

struct BracketView: View {
    var matches: [Match]
    
    var body: some View {
        VStack {
            ForEach(matches, id: \.self) { match in
                HStack {
                    Text(match.player1)
                    Spacer()
                    if let winner = match.winner {
                        Text(winner)
                    } else {
                        Text("vs.")
                    }
                    Spacer()
                    Text(match.player2)
                }
            }
        }
    }
}
