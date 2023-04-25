//
//  TournamentDetailView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct TournamentDetailScreen: View {
    let tournament: Tournament
    @State private var tournamentImage: UIImage? = nil
    
    var body: some View {
        List {
            if let image = tournamentImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding(.horizontal)
            } else {
                ProgressView()
                    .frame(height: 200)
            }
            
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
                NavigationLink(destination: PlayerListView(tournament: tournament)) {
                    Text("Players signed up:")
                        .foregroundColor(.blue) // Set text color
                }
                Spacer()
                Text("\(tournament.players.count)")
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
            
            if tournament.createdBy == Auth.auth().currentUser?.uid {
                VStack {
                    Text("Note: As an admin, you can start the tournament automatically when the start time is reached, or manually by pressing the button below.")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button(action: startTournament) {
                        Text("Start Tournament")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(5)
                            .padding(.horizontal, 20)
                    }
                    .padding(.vertical)
                }
            }

            
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
        .onAppear {
            // Load the tournament image from Firestore storage
            if let imageUrl = tournament.imageUrl {
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let imagesRef = storageRef.child(imageUrl)
                
                imagesRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error downloading image: \(error.localizedDescription)")
                    } else {
                        tournamentImage = UIImage(data: data!)
                    }
                  }
            }
        }
    }
    
    func startTournament() {
        TournamentGenerator.startTournament(tournament) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
