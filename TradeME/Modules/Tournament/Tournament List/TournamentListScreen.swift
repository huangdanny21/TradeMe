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
    @State var showingPopup = false

    var body: some View {
        NavigationView {
            List(viewModel.tournaments) { tournament in
                NavigationLink(destination: TournamentDetailScreen(tournament: tournament)) {
                    Text(tournament.name)
                }
            }
            .navigationBarTitle("Tournaments")
            .navigationBarItems(trailing: Button(action: {
                viewModel.isCreatingTournament = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $viewModel.isCreatingTournament) {
                TournamentCreationScreen()
            }
        }
        .onAppear {
            viewModel.fetchTournaments()
        }
        .popup(isPresented: $showingPopup) {
            TournamentCreationScreen()
        } customize: {
            $0
                .type(.floater())
                .position(.top)
                .position(.bottom)
                .closeOnTap(false)
                .dragToDismiss(true)
            
        }
    }
}

struct TournamentListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TournamentListScreen()
    }
}
