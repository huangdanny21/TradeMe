//
//  EditProfileView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import Firebase
import PopupView

struct EditProfileView: View {
    
    @State private var email = ""
    @State private var konamiId = ""
    @State private var top5Cards = [FSCard]()
    @State private var showCardSearchView = false
    
    var body: some View {
        List {
            Section(header: Text("Personal Information")) {
                TextField("Email", text: $email)
                TextField("Konami ID", text: $konamiId)
            }
            
            Section(header: Text("Top 5 Cards")) {
                if top5Cards.isEmpty {
                    Text("You haven't added any cards to your top 5 yet.")
                } else {
                    List(top5Cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.name)
                                .font(.headline)
                            Text("$\(card.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                }
                
                Button(action: {
                    showCardSearchView = true
                }, label: {
                    Text("Add a Card to Top 5")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                })
            }
            
            Button(action: {
                saveProfileData()
            }, label: {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            })
        }
        .sheet(isPresented: $showCardSearchView) {
            CardSearchView { card in
                if top5Cards.count < 5 {
                    top5Cards.append(card.result.toFSCard())
                }
            }
        }
        .navigationBarTitle("Edit Profile")
        .onAppear {
            // Retrieve user data from Firestore
            let db = Firestore.firestore()
            let currentUser = Auth.auth().currentUser
            
            db.collection("users").document(currentUser!.uid).getDocument { (snapshot, error) in
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    let data = snapshot.data()
                    if let email = data?["email"] as? String {
                        self.email = email
                    }
                    if let konamiId = data?["konamiId"] as? String {
                        self.konamiId = konamiId
                    }
                    
                    // Retrieve user's top 5 cards from Firestore
                    if let cardIds = data?["topCards"] as? [String] {
                        var topCards: [FSCard] = []
                        let dispatchGroup = DispatchGroup()
                        
                        for cardId in cardIds {
                            dispatchGroup.enter()
                            db.collection("cards").document(cardId).getDocument { (snapshot, error) in
                                if let error = error {
                                    print("Error fetching card data for card ID \(cardId): \(error.localizedDescription)")
                                    dispatchGroup.leave()
                                    return
                                }
                                
                                if let snapshot = snapshot {
                                    let data = snapshot.data()
                                    if let name = data?["name"] as? String,
                                       let tag = data?["tag"] as? String,
                                       let rarity = data?["rarity"] as? String,
                                       let price = data?["price"] as? Double {
                                        let card = FSCard(name: name, tag: tag, rarity: rarity, price: price)
                                        topCards.append(card)
                                    }
                                }
                                
                                dispatchGroup.leave()
                            }
                        }
                        
                        dispatchGroup.notify(queue: .main) {
                            self.top5Cards = topCards
                        }
                    }
                }
            }
        }
    }
    
    func saveProfileData() {
        let db = Firestore.firestore()
        let currentUser = Auth.auth().currentUser
        
        // Update user document with new data
        db.collection("users").document(currentUser!.uid).setData([
            "email": email,
            "konamiId": konamiId,
            "topCards": top5Cards.map { $0.toFirestore() }
        ], merge: true) { error in
            if let error = error {
                print("Error updating user data: \(error.localizedDescription)")
            } else {
                print("User data updated successfully!")
            }
        }
    }
}
