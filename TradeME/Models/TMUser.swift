//
//  TMUser.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

class TMUser: ObservableObject {
    let db = Firestore.firestore()
    let uid: String
    @Published var credit: Double = 0
    @Published var transactions: [Transaction] = []
    
    init(uid: String) {
        self.uid = uid
        fetchCredit()
        fetchTransactions()
    }
    
    private func fetchCredit() {
        db.collection("users").document(uid).getDocument { snapshot, error in
            guard let snapshot = snapshot, let data = snapshot.data() else {
                print("Error fetching user credit: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            self.credit = data["credit"] as? Double ?? 0
        }
    }
    
    private func fetchTransactions() {
        db.collection("users").document(uid).collection("transactions").order(by: "timestamp", descending: true).addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("Error fetching user transactions: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                self.transactions = try snapshot.documents.compactMap { document in
                    try document.data(as: Transaction.self)
                }
            } catch {
                print("Error decoding user transactions: \(error.localizedDescription)")
            }
        }
    }
    
    func addCredit(_ amount: Double) {
        let transaction = Transaction(amount: amount, type: "credit", timestamp: Date())
        do {
            let _ = try db.collection("users").document(uid).collection("transactions").addDocument(from: transaction)
            db.collection("users").document(uid).updateData(["credit": FieldValue.increment(amount)])
        } catch {
            print("Error adding credit transaction: \(error.localizedDescription)")
        }
    }
    
    func subtractCredit(_ amount: Double) {
        let transaction = Transaction(amount: amount, type: "debit", timestamp: Date())
        do {
            let _ = try db.collection("users").document(uid).collection("transactions").addDocument(from: transaction)
            db.collection("users").document(uid).updateData(["credit": FieldValue.increment(-amount)])
        } catch {
            print("Error adding debit transaction: \(error.localizedDescription)")
        }
    }
}
