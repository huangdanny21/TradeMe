//
//  TournamentCreationViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import FirebaseFirestore
import SwiftUI
import FirebaseStorage
import FirebaseAuth

class TournamentCreationViewModel: ObservableObject {
    
    // properties to hold tournament details
    @Published var tournamentName = ""
    @Published var numberOfPlayers = ""
    @Published var entryFee = ""
    @Published var prizeMoney = ""
    @Published var tournamentStartDate = Date()
    @Published var tournamentStartTime = Date()
    @Published var tournamentImage: UIImage?
    
    // state to handle form validation and submission
    @Published var showValidationAlert = false
    @Published var validationErrorMessage = ""
    @Published var isSubmitting = false
    
    // reference to firestore
    private let db = Firestore.firestore()
    
    // reference to firebase storage
    private let storage = Storage.storage()
    
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
        let tournament = Tournament(name: tournamentName, rounds: [], numberOfPlayers: numPlayers, entryFee: fee, prizeMoney: prize, startDate: combinedStartDateAndTime ?? Date(), players: [], createdBy: Auth.auth().currentUser?.uid ?? UUID().uuidString, started: false, ended: false)
        
        // submit the tournament to firestore
        isSubmitting = true
        db.collection("tournaments").document("\(Auth.auth().currentUser?.uid ?? "")").setData(tournament.toDict()) { error in
            if let error = error {
                print("Error adding tournament: \(error.localizedDescription)")
                self.isSubmitting = false
                return
            }
            
            guard let image = self.tournamentImage, let imageData = image.jpegData(compressionQuality: 0.5) else {
                self.isSubmitting = false
                return
            }
            
            // upload the image to Firebase Storage
            let storageRef = self.storage.reference().child("tournaments/\(tournament.name).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let uploadTask = storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading tournament image: \(error.localizedDescription)")
                } else {
                    print("Tournament image uploaded successfully!")
                }
                self.isSubmitting = false
            }
            
            uploadTask.observe(.progress) { snapshot in
                let percentComplete = Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                print("Tournament image upload progress: \(percentComplete)")
            }
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
