//
//  YGOCardType.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import FirebaseFirestoreSwift

enum YGOCardType: Codable {
    case monster(Monster)
    case spell(Spell)
    case trap(Trap)
    case extraDeck(ExtraDeck)

    enum Monster: String, Codable {
        case normal
        case effect
    }
    enum Spell: String, Codable {
        case normal
        case quickPlay
        case field
        case equip
        case continuous
        case ritual
    }

    enum Trap: String, Codable {
        case normal
        case continuous
        case counter
    }
    
    enum ExtraDeck: String, Codable {
        case fusion
        case synchro
        case xyz
        case link
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .monster(let value):
            try container.encode(value.rawValue)
        case .spell(let value):
            try container.encode(value.rawValue)
        case .trap(let value):
            try container.encode(value.rawValue)
        case .extraDeck(let value):
            try container.encode(value.rawValue)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case Monster.normal.rawValue, Monster.effect.rawValue:
            self = .monster(Monster(rawValue: rawValue)!)
        case Spell.normal.rawValue, Spell.quickPlay.rawValue, Spell.field.rawValue, Spell.equip.rawValue, Spell.continuous.rawValue, Spell.ritual.rawValue:
            self = .spell(Spell(rawValue: rawValue)!)
        case Trap.normal.rawValue, Trap.continuous.rawValue, Trap.counter.rawValue:
            self = .trap(Trap(rawValue: rawValue)!)
        case ExtraDeck.fusion.rawValue, ExtraDeck.synchro.rawValue, ExtraDeck.xyz.rawValue, ExtraDeck.link.rawValue:
            self = .trap(Trap(rawValue: rawValue)!)
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid YGOCardType")
        }
    }
}

extension YGOCardType {
    var firestoreValue: Any {
        switch self {
        case .monster(let monsterType):
            return ["type": "monster", "value": monsterType.rawValue]
        case .spell(let spellType):
            return ["type": "spell", "value": spellType.rawValue]
        case .trap(let trapType):
            return ["type": "trap", "value": trapType.rawValue]
        case .extraDeck(let extraDeck):
            return["type": "extraDeck", "value": extraDeck.rawValue]
        }
    }

    init?(firestoreValue: Any?) {
        guard let dictionary = firestoreValue as? [String: Any],
            let type = dictionary["type"] as? String,
            let value = dictionary["value"] as? String else {
                return nil
        }

        switch type {
        case "monster":
            guard let monsterType = Monster(rawValue: value) else {
                return nil
            }
            self = .monster(monsterType)
        case "spell":
            guard let spellType = Spell(rawValue: value) else {
                return nil
            }
            self = .spell(spellType)
        case "trap":
            guard let trapType = Trap(rawValue: value) else {
                return nil
            }
            self = .trap(trapType)
        case "extraDeck":
            guard let extraDeckType = ExtraDeck(rawValue: value) else {
                return nil
            }
            self = .extraDeck(extraDeckType)
        default:
            return nil
        }
    }
}

