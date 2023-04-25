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

struct TournamentBracketView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentBracketView(tournament: Tournament(name: "Test1", rounds: [], numberOfPlayers: 64, entryFee: 5, prizeMoney: 50, startDate: Date(), players: []))
    }
}
