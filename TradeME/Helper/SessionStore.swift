//
//  SessionStore.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SessionStore: ObservableObject {
    private var listenerRegistration: ListenerRegistration?
    private let auth = Auth.auth()
    private let db = Firestore.firestore()

    @Published var user: FSUser?
    @Published var isLoggedIn = false

    init() {
        auth.addStateDidChangeListener { [weak self] (auth, user) in
            if let user = user {
                self?.fetchUser(uid: user.uid)
                self?.isLoggedIn = true
            } else {
                self?.user = nil
                self?.isLoggedIn = false
            }
        }
    }

    deinit {
        listenerRegistration?.remove()
    }

    private func fetchUser(uid: String) {
        listenerRegistration = db.collection("users").document(uid)
            .addSnapshotListener { [weak self] (snapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                    return
                }
                guard let data = snapshot?.data(),
                      let user = try? Firestore.Decoder().decode(FSUser.self, from: data) else { return }
                self.user = user
            }
    }

    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                completion(error)
            } else if let user = result?.user {
                self?.saveUserData(uid: user.uid, email: email, completion: completion)
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    func signOut() {
        try? auth.signOut()
    }

    func updateUser(_ user: FSUser, completion: @escaping (Error?) -> Void) {
        guard let uid = auth.currentUser?.uid else { return }
        db.collection("users").document(uid).setData(user.toDictionary(), merge: true) { (error) in
            completion(error)
        }
    }

    private func saveUserData(uid: String, email: String, completion: @escaping (Error?) -> Void) {
        let user = FSUser(id: uid, email: email)
        db.collection("users").document(uid).setData(user.toDictionary()) { (error) in
            completion(error)
        }
    }
}
