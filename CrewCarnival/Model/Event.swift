//
//  Event.swift
//  CrewCarnival
//
//  Created by Yap Justin on 26/06/23.
//

import Foundation

struct Event: Codable, Equatable {
    var id = UUID()
    var duration: Int
    var instruction: String
    var objective: Objective
}

enum Objective: Codable {
  case lookLeft, lookFront, lookRight, turnLeft, turnRight, slow10, slow20, slow30
}
