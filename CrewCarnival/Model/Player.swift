//
//  Player.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import Foundation

struct Player: Codable, Identifiable, Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name && lhs.role == rhs.role && lhs.isReady == rhs.isReady && lhs.event == rhs.event
    }
    
    var id = UUID()
    var name: String
    var role: Role?
    var isReady: Bool = false
    var event = Event(duration: -1, instruction: "")
    
    func getStringRole() -> String {
        switch role {
        case Role.lookout?:
            return "Lookout"
        case Role.helmsman?:
            return "Helmsman"
        case Role.sailingMaster?:
            return "Sailing Master"
        case Role.cabinBoy?:
            return "Cabin Boy"
        default:
            return "Blacksmith"
        }
    }
}

enum Role: Codable {
  case helmsman, lookout, sailingMaster, cabinBoy, blackSmith
}
