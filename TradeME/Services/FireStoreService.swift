//
//  FireStoreService.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()

    func getDocument<T: Codable>(collectionName: String, documentId: String, completion: @escaping (Result<T, Error>) -> Void) {
        let docRef = db.collection(collectionName).document(documentId)
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                do {
                    guard let data = document.data() else {
                        completion(.failure(FirestoreError.documentNotFound))
                        return
                    }
                    let model = try Firestore.Decoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(FirestoreError.documentNotFound))
            }
        }
    }

    func saveDocument<T: Codable>(collectionName: String, data: T, documentId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let docData = try Firestore.Encoder().encode(data)
            let docRef = db.collection(collectionName).document(documentId)
            docRef.setData(docData) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

enum FirestoreError: Error {
    case documentNotFound
}
