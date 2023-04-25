//
//  PlayerListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI

struct PlayerListView: View {
    let tournament: Tournament
    
    var body: some View {
        List(tournament.players) { player in
            Text(player.name)
        }
        .navigationTitle("Players")
    }
}
