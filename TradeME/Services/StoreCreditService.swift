//
//  StoreCreditService.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Firebase

class StoreCreditService {
    
    // 1. Store credit balance
    func getStoreCreditBalance(for userID: String, completion: @escaping (StoreCredit?) -> Void) {
        let db = Firestore.firestore()
        db.collection("storeCreditBalances").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("Error getting store credit balance for user \(userID): \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = snapshot?.data(),
                  let balance = data["balance"] as? Double
            else {
                completion(nil)
                return
            }
            
            let storeCredit = StoreCredit(userID: userID, balance: balance)
            completion(storeCredit)
        }
    }
    
    // 2. Store credit purchases
    func purchaseWithStoreCredit(amount: Double, for userID: String) {
        let db = Firestore.firestore()
        getStoreCreditBalance(for: userID) { storeCredit in
            guard let storeCredit = storeCredit else {
                print("Error purchasing with store credit: could not retrieve store credit balance for user \(userID)")
                return
            }
            
            if storeCredit.balance >= amount {
                let newBalance = storeCredit.balance - amount
                db.collection("storeCreditBalances").document(userID).setData(["balance": newBalance], merge: true)
                db.collection("transactions").addDocument(data: ["userID": userID, "type": "purchase", "amount": amount, "date": Timestamp(date: Date())])
            } else {
                print("Error purchasing with store credit: user \(userID) does not have enough store credit")
            }
        }
    }
    
    // 3. Store credit top-ups
    func topUpStoreCredit(amount: Double, for userID: String) {
        let db = Firestore.firestore()
        getStoreCreditBalance(for: userID) { storeCredit in
            let newBalance = storeCredit?.balance ?? 0 + amount
            db.collection("storeCreditBalances").document(userID).setData(["balance": newBalance], merge: true)
            db.collection("transactions").addDocument(data: ["userID": userID, "type": "topUp", "amount": amount, "date": Timestamp(date: Date())])
        }
    }
    
    // 4. Store credit refunds
    func refundStoreCredit(amount: Double, for userID: String) {
        let db = Firestore.firestore()
        getStoreCreditBalance(for: userID) { storeCredit in
            guard let storeCredit = storeCredit else {
                print("Error refunding store credit: could not retrieve store credit balance for user \(userID)")
                return
            }
            
            let newBalance = storeCredit.balance - amount
            db.collection("storeCreditBalances").document(userID).setData(["balance": newBalance], merge: true)
            db.collection("transactions").addDocument(data: ["userID": userID, "type": "refund", "amount": amount, "date": Timestamp(date: Date())])
        }
    }
}

