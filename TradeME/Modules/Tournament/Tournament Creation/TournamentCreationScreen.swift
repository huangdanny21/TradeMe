//
//  File.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore

struct TournamentCreationScreen: View {
    
    // view model
    @ObservedObject var viewModel: TournamentCreationViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tournament Details")) {
                    TextField("Tournament Name", text: $viewModel.tournamentName)
                    
                    TextField("Number of Players", text: $viewModel.numberOfPlayers)
                        .keyboardType(.numberPad)
                    
                    TextField("Entry Fee", text: $viewModel.entryFee)
                        .keyboardType(.decimalPad)
                    
                    TextField("Prize Money", text: $viewModel.prizeMoney)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Start Date", selection: $viewModel.tournamentStartDate, displayedComponents: .date)
                    
                    DatePicker("Start Time", selection: $viewModel.tournamentStartTime, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    Button(action: viewModel.createTournament) {
                        if viewModel.isSubmitting {
                            ProgressView()
                        } else {
                            Text("Create Tournament")
                        }
                    }
                    .disabled(viewModel.isSubmitting)
                }
            }
        }
        .navigationTitle("Create Tournament")
        .alert(isPresented: $viewModel.showValidationAlert, content: {
            Alert(title: Text("Validation Error"), message: Text(viewModel.validationErrorMessage), dismissButton: .default(Text("OK")))
        })
    }
}

struct TournamentCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TournamentCreationScreen(viewModel: TournamentCreationViewModel())
    }
}
