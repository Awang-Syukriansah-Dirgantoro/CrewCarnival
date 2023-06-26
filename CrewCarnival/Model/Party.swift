//
//  Party.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import Foundation

struct Party: Codable, Identifiable, Equatable {
    static func == (lhs: Party, rhs: Party) -> Bool {
        return lhs.players == rhs.players && lhs.isPlaying == rhs.isPlaying
    }
    
    var id = UUID()
    var players = [Player]()
    var isPlaying = false
}
