//
//  TournamentGenerator.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation
import Firebase

class TournamentGenerator {
    static func generateTournament(for tournament: Tournament) -> Tournament {
        var tournament = tournament
        var rounds: [Round] = []
        
        let shuffledPlayers = tournament.players.shuffled()
        
        // Generate the first round matches
        var roundMatches: [Match] = []
        for i in 0..<shuffledPlayers.count/2 {
            let match = Match(player1: shuffledPlayers[i], player2: shuffledPlayers[i+1], roundNumber: 1)
            roundMatches.append(match)
        }
        
        rounds.append(Round(number: 1, date: tournament.startDate, matches: roundMatches, players: shuffledPlayers, inProgress: true))
        
        tournament.rounds = rounds
        return tournament
    }
    
    static func startTournament(_ tournament: Tournament, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        var updatedTournament = tournament
        updatedTournament.started = true
        db.collection("tournaments").document(updatedTournament.id ?? "").updateData(["started": true]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
