//
//  TournamentListViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TournamentListViewModel: ObservableObject {
    @Published var tournaments = [Tournament]()
    private var tournamentsListener: ListenerRegistration?
    private let db = Firestore.firestore()
    @Published var isCreatingTournament = false

    init() {
        fetchTournaments()
    }
    
    func fetchTournaments() {
        tournamentsListener = db.collection("tournaments")
            .order(by: "startDate")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                self.tournaments = documents.compactMap { queryDocumentSnapshot -> Tournament? in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    guard let name = data["name"] as? String,
                          let numberOfPlayers = data["numberOfPlayers"] as? Int,
                          let entryFee = data["entryFee"] as? Double,
                          let prizeMoney = data["prizeMoney"] as? Double,
                          let startDateString = data["startDate"] as? String,
                          let started = data["started"] as? Bool,
                          let ended = data["ended"] as? Bool,
                          let startDate = dateFormatter.date(from: startDateString) else {
                        print("Error parsing tournament data")
                        return nil
                    }
                    
                    let tournament = Tournament(id: id, name: name, rounds: [], numberOfPlayers: numberOfPlayers, entryFee: entryFee, prizeMoney: prizeMoney, startDate: startDate, players: [], started: started, ended: ended)
                    return tournament
                }
            }
    }

    
    func addTournament(name: String, numberOfPlayers: Int, entryFee: Double, prizeMoney: Double, startDate: Date) {
        let newTournament = Tournament(name: name, rounds: [], numberOfPlayers: numberOfPlayers, entryFee: entryFee, prizeMoney: prizeMoney, startDate: startDate, players: [], started: false, ended: false)
        do {
            let _ = try db.collection("tournaments").addDocument(from: newTournament)
        } catch {
            print("Error adding tournament: \(error)")
        }
    }
    
    deinit {
        tournamentsListener?.remove()
    }
}
