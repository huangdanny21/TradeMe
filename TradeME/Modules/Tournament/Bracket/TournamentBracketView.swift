//
//  TournamentBracketView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI

struct TournamentBracketView: View {
    let tournament: Tournament
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(tournament.rounds) { round in
                    RoundView(round: round)
                }
            }
            .padding()
        }
        .navigationBarTitle(tournament.name)
    }
}
