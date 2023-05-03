//
//  TournamentBracketView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI

struct TournamentBracketView: View {
    var tournament: Tournament
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(tournament.rounds, id: \.self) { round in
                HStack(spacing: 0) {
                    ForEach(round.matches, id: \.self) { match in
                        MatchView(match: match)
                            .frame(width: 150, height: 60)
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct MatchView: View {
    var match: Match
    
    var body: some View {
        VStack {
            PlayerView(player: match.player1)
            Divider()
            PlayerView(player: match.player2)
        }
    }
}

struct PlayerView: View {
    var player: Player?
    
    var body: some View {
        Text(player?.name ?? "BYE")
    }
}
