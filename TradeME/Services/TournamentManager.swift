//
//  TournamentManager.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


class TournamentManager: ObservableObject {
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
    
    func signUp(player: String, tournament: Tournament) {
        guard var round = tournament.rounds.first(where: { $0.players.count < 4 }) else {
            print("Error signing up player: tournament full")
            return
        }
        if !round.players.contains(player) {
            round.players.append(player)
            do {
                let roundIndex = tournament.rounds.firstIndex(where: { $0.id == round.id })!
                try db.collection("tournaments").document(tournament.id!).updateData(["rounds.\(roundIndex)": round])
            } catch {
                print("Error updating tournament: \(error.localizedDescription)")
            }
        }
    }
    
    func announceRounds(for tournament: Tournament) {
        var players = tournament.rounds.flatMap { $0.players }
        players.shuffle()
        var rounds: [Round] = []
        for i in 1...4 {
            let round = Round(number: i, date: Date(), players: Array(players.prefix(4)))
            players.removeFirst(4)
            rounds.append(round)
        }
        do {
            try db.collection("tournaments").document(tournament.id!).updateData(["rounds": rounds])
        } catch {
            print("Error updating tournament: \(error.localizedDescription)")
        }
    }
}
