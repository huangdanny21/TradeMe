//
//  TournamentBracketView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI
import KRTournamentView

struct TournamentBracketView: UIViewRepresentable {
    var tournament: Tournament
    
    func makeUIView(context: Context) -> KRTournamentView {
        let tournamentView = KRTournamentView(frame: .zero)
        tournamentView.setDataSource(self)
        return tournamentView
    }
    
    func updateUIView(_ uiView: KRTournamentView, context: Context) {
        uiView.reloadData()
    }
}

