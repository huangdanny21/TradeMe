//
//  TournamentCreationViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import FirebaseFirestore

// ViewModel for the TournamentCreationScreen
class TournamentCreationViewModel: ObservableObject {
    
    // properties to hold tournament details
    @Published var tournamentName = ""
    @Published var numberOfPlayers = ""
    @Published var entryFee = ""
    @Published var prizeMoney = ""
    @Published var tournamentStartDate = Date()
    @Published var tournamentStartTime = Date()
    
    // state to handle form validation and submission
    @Published var showValidationAlert = false
    @Published var validationErrorMessage = ""
    @Published var isSubmitting = false
    
    // reference to firestore
    private let db = Firestore.firestore()
    
    // function to create a new tournament
    func createTournament() {
        // validate form fields
        guard !tournamentName.isEmpty, !numberOfPlayers.isEmpty, !entryFee.isEmpty, !prizeMoney.isEmpty else {
            validationErrorMessage = "Please fill out all fields"
            showValidationAlert = true
            return
        }
        
        guard let numPlayers = Int(numberOfPlayers), let fee = Double(entryFee), let prize = Double(prizeMoney) else {
            validationErrorMessage = "Please enter valid numbers for number of players, entry fee, and prize money"
            showValidationAlert = true
            return
        }
        
        // combine the start date and start time
        let combinedStartDateAndTime = combineDateAndTime(date: tournamentStartDate, time: tournamentStartTime)
        
        // create the tournament object
        let tournament = Tournament(name: tournamentName, rounds: [], numberOfPlayers: numPlayers, entryFee: fee, prizeMoney: prize, startDate: combinedStartDateAndTime ?? Date(), players: [], started: false, ended: false)
        
        // submit the tournament to firestore
        isSubmitting = true
        db.collection("tournaments").addDocument(data: tournament.toDict()) { error in
            if let error = error {
                print("Error adding tournament: \(error.localizedDescription)")
            } else {
                print("Tournament added successfully!")
            }
            self.isSubmitting = false
        }
    }
    
    // function to combine a date and time into a single date object
    func combineDateAndTime(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents)
    }
}
