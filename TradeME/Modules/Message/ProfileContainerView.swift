//
//  ProfileContainerView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI

struct ProfileContainerView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        if let userId = session.user?.id {
            EditProfileView(userId: userId)
        } else {
            LoginView(session: session)
        }
    }
}


