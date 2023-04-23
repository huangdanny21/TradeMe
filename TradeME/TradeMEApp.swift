//
//  TradeMEApp.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    let db = Firestore.firestore()

    return true
  }
}
@main
struct TradeMEApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
