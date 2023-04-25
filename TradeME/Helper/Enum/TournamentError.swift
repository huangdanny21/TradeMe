//
//  TournamentError.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation

enum TournamentError: Error {
    case invalidNumberOfPlayers
    case invalidEntryFee
    case invalidPrizeMoney
    case invalidStartDate
    case tournamentAlreadyStarted
    case tournamentAlreadyEnded
    case unauthorizedAccess
    case firestoreError
}

