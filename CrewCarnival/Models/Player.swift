//
//  Player.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import Foundation

struct Player: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var role: Role?
    var isReady: Bool = false
}

enum Role: Codable {
  case helmsman, lookout, sailingMaster, cabinBoy, blackSmith
}
