//
//  TournamentDetailView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI

struct TournamentDetailScreen: View {
    let tournament: Tournament
    
    var body: some View {
        VStack {
            Text(tournament.name)
                .font(.title)
                .padding()
            
            HStack {
                Text("Number of Players:")
                Spacer()
                Text("\(tournament.numberOfPlayers)")
            }
            .padding()
            
            HStack {
                Text("Entry Fee:")
                Spacer()
                Text(String(format: "$%.2f", tournament.entryFee))
            }
            .padding()
            
            HStack {
                Text("Prize Money:")
                Spacer()
                Text(String(format: "$%.2f", tournament.prizeMoney))
            }
            .padding()
            
            HStack {
                Text("Start Date:")
                Spacer()
                Text("\(tournament.startDate, formatter: DateFormatter.custom)")
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}
