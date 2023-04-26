//
//  PlayerListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct PlayerListView: View {
    let tournament: Tournament
    
    var body: some View {
        List(tournament.players) { player in
            Text(player.name)
        }
        .navigationTitle("Players")
        .onAppear {
            if tournament.players.isEmpty {
                let randomPlayers = PlayerListView.generateRandomPlayersArray(count: tournament.numberOfPlayers)
                tournament.players = randomPlayers
                // Save changes to tournament object in Firestore
                let db = Firestore.firestore()
                db.collection("tournaments").document(Auth.auth().currentUser?.uid ?? "").setData(tournament.toDict())
            }
            }
    }
    
    static func generateRandomPlayersArray(count: Int) -> [Player] {
        var players = [Player]()
        let names = ["Alice", "Bob", "Charlie", "David", "Emily", "Frank", "Grace", "Henry", "Isabella", "Jack", "Kate", "Liam", "Mia", "Nora", "Oliver", "Penelope", "Quinn", "Riley", "Sophia", "Thomas", "Ursula", "Victoria", "William", "Xavier", "Yara", "Zachary"]
        let domains = ["gmail.com", "yahoo.com", "hotmail.com", "aol.com", "outlook.com"]
        let areaCodes = ["212", "718", "917", "646", "347", "845", "914", "516", "631", "718", "646", "917", "347", "929", "203", "860", "959", "475", "413", "617", "508", "774", "781", "978", "301", "410", "443", "240", "301", "703", "571", "804", "757", "540", "276", "434", "540", "571", "703"]
        
        for _ in 1...count {
            let nameIndex = Int.random(in: 0..<names.count)
            let emailDomainIndex = Int.random(in: 0..<domains.count)
            let areaCodeIndex = Int.random(in: 0..<areaCodes.count)
            let phoneNumber = "\(areaCodes[areaCodeIndex])-555-\(Int.random(in: 1000..<9999))"
            let player = Player(name: names[nameIndex], email: "\(names[nameIndex])\(Int.random(in: 1..<100))@\(domains[emailDomainIndex])", phoneNumber: phoneNumber)
            players.append(player)
        }
        return players
    }
}
