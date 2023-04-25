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
                Text(tournament.entryFee.toUSD())
            }
            .padding()
            
            HStack {
                Text("Prize Money:")
                Spacer()
                Text(tournament.prizeMoney.toUSD())
            }
            .padding()
            
            HStack {
                Text("Start Date:")
                Spacer()
                Text("\(tournament.startDate, formatter: DateFormatter.custom)")
            }
            .padding()
            
            NavigationLink(destination: TournamentSignUpView(tournament: tournament)) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
            }
            
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
