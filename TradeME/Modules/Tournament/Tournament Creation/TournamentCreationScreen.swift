//
//  File.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI

struct TournamentCreationScreen: View {
    
    // view model
    @ObservedObject var viewModel: TournamentCreationViewModel
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Tournament Details")) {
                    if let image = viewModel.tournamentImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    
                    Button(action: {
                        showingImagePicker = true
                    }, label: {
                        Text(viewModel.tournamentImage == nil ? "Add Tournament Image" : "Change Tournament Image")
                    })
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .sheet(isPresented: $showingImagePicker, content: {
                        ImagePicker(completionHandler: loadImage)
                    })
                     
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
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Create Tournament")
        .alert(isPresented: $viewModel.showValidationAlert, content: {
            Alert(title: Text("Validation Error"), message: Text(viewModel.validationErrorMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    func loadImage(image: UIImage?) {
        viewModel.tournamentImage = image
    }
}

struct TournamentCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TournamentCreationScreen(viewModel: TournamentCreationViewModel())
    }
}
