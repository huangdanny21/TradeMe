//
//  TournamentListScreen.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore
import PopupView

struct TournamentListScreen: View {
    @StateObject private var viewModel = TournamentListViewModel()
    @State private var isPresentingTournamentCreation = false
    
    var body: some View {
        NavigationView {
            List(viewModel.tournaments) { tournament in
                NavigationLink(destination: TournamentDetailScreen(tournament: tournament)) {
                    Text(tournament.name)
                }
            }
            .navigationBarTitle("Tournaments")
            .navigationBarItems(trailing: Button(action: {
                isPresentingTournamentCreation = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isPresentingTournamentCreation) {
                NavigationView {
                    TournamentCreationScreen(viewModel: TournamentCreationViewModel())
                        .navigationBarTitle("New Tournament")
                        .navigationBarItems(trailing: Button(action: {
                            isPresentingTournamentCreation = false
                        }) {
                            Text("Done")
                        })
                }
            }
        }
        .onAppear {
            viewModel.fetchTournaments()
        }
    }
}


struct TournamentListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TournamentListScreen()
    }
}
