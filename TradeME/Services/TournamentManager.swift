//
//  TournamentManager.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class TournamentManager {
    static let shared = TournamentManager()
    let db = Firestore.firestore()
    @Published var tournaments: [Tournament] = []
    
    init() {
        fetchTournaments()
    }
    
    private func fetchTournaments() {
        db.collection("tournaments").order(by: "name").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("Error fetching tournaments: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                self.tournaments = try snapshot.documents.compactMap { document in
                    try document.data(as: Tournament.self)
                }
            } catch {
                print("Error decoding tournaments: \(error.localizedDescription)")
            }
        }
    }

    func announceRounds(for tournament: Tournament) {
        var players = tournament.rounds.flatMap { $0.players }
        players.shuffle()
        var rounds: [Round] = []
        for i in 1...4 {
            let round = Round(number: i, date: Date(), matches: generateMatches(for: players, roundNumber: i), players: players, inProgress: false)
            players.removeFirst(4)
            rounds.append(round)
        }
        db.collection("tournaments").document(tournament.id!).updateData(["rounds": rounds])
    }
    
    // generate tournament with given players
    func generateTournament(with players: [Player], name: String, numberOfPlayers: Int, entryFee: Double, prizeMoney: Double, startDate: Date) -> Tournament {
        var players = players
        let numOfByes = getNextPowerOfTwo(numberOfPlayers) - numberOfPlayers
        
        // add byes if necessary
        if numOfByes > 0 {
            let byePlayer = Player(name: "BYE", email: "", phoneNumber: "")
            for _ in 0..<numOfByes {
                players.append(byePlayer)
            }
        }
        
        // shuffle the players
        players.shuffle()
        
        // create rounds
        var rounds = [Round]()
        let numberOfRounds = Int(log2(Double(players.count)))
        for i in 1...numberOfRounds {
            let roundMatches = generateMatches(for: players, roundNumber: i)
            let round = Round(number: i, date: startDate, matches: roundMatches, players: players, inProgress: true)
            rounds.append(round)
        }
        
        // create the tournament
        let tournament = Tournament(name: name, rounds: rounds, numberOfPlayers: numberOfPlayers, entryFee: entryFee, prizeMoney: prizeMoney, startDate: startDate, players: players, createdBy: Auth.auth().currentUser?.uid ?? UUID().uuidString, started: false, ended: false)
        
        // TODO: Add the tournament to Firestore
        do {
            let documentRef = try db.collection("tournaments").addDocument(from: tournament)
            var tournament = tournament
            tournament.id = documentRef.documentID
            return tournament
        } catch {
            print("Error adding document: \(error)")
            return tournament
        }
    }
    
    // generate matches for a round
    private func generateMatches(for players: [Player], roundNumber: Int) -> [Match] {
        var matches = [Match]()
        let numberOfMatches = players.count / 2
        
        for i in 0..<numberOfMatches {
            let player1 = players[i]
            let player2 = players[players.count - 1 - i]
            let match = Match(player1: player1, player2: player2, roundNumber: roundNumber)
            matches.append(match)
        }
        
        return matches
    }
    
    // get the next power of two
    private func getNextPowerOfTwo(_ number: Int) -> Int {
        var power = 1
        while power < number {
            power *= 2
        }
        return power
    }
}
