//
//  TournamentListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore
import PopupView

struct TournamentListView: View {
    @StateObject private var viewModel = TournamentListViewModel()
    @State private var isPresentingTournamentCreation = false
    
    var body: some View {
        NavigationView {
            List(viewModel.tournaments, id: \.name) { tournament in
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
                    TournamentCreationView(viewModel: TournamentCreationViewModel())
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
        TournamentListView()
    }
}
