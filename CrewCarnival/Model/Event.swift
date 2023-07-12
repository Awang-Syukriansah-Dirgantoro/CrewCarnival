//
//  Event.swift
//  CrewCarnival
//
//  Created by Yap Justin on 26/06/23.
//

import Foundation

struct Event: Codable, Equatable {
    var id = UUID()
    var duration: Double
    var instruction: String
    var objective: Objective?
    var isCompleted = false
}

enum Objective: Codable {
  case lookLeft, lookRight, turnLeft, turnRight, slow10, slow20, slow30, steer, sail, binocular
}
