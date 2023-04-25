//
//  TournamentGenerator.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation

class TournamentGenerator {
    static func generateTournament(for tournament: Tournament) -> Tournament {
        var tournament = tournament
        var rounds: [Round] = []
        
        let numberOfRounds = Int(log2(Double(tournament.numberOfPlayers)))
        let shuffledPlayers = tournament.players.shuffled()
        
        // Generate the first round matches
        var roundMatches: [Match] = []
        for i in 0..<shuffledPlayers.count/2 {
            let match = Match(player1: shuffledPlayers[i], player2: shuffledPlayers[i+1], roundNumber: 1)
            roundMatches.append(match)
        }
        
        rounds.append(Round(number: 1, date: tournament.startDate, matches: roundMatches, players: shuffledPlayers))
        
//        // Generate the rest of the rounds
//        for i in 1..<numberOfRounds {
//            let previousRound = rounds[i-1]
//            var roundMatches: [Match] = []
//
//            for j in 0..<previousRound.matches.count {
//                let player1 = previousRound.matches[j].winner!
//                let player2 = previousRound.matches[j+1].winner!
//                let match = Match(player1: player1, player2: player2)
//                roundMatches.append(match)
//            }
//
//            let round = Round(number: i+1, date: previousRound.date.addingTimeInterval(TimeInterval(7*24*60*60)), matches: roundMatches, players: previousRound.matches.flatMap { [$0.player1.name, $0.player2.name] })
//            rounds.append(round)
//        }
        
        tournament.rounds = rounds
        return tournament
    }
}
