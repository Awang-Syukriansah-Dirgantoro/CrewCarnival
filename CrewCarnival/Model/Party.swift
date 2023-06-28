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
    var lives = 3
    
    mutating func generateLookoutEvent() {
        for (index, player) in players.enumerated() {
            if player.role == Role.lookout {
                players[index].event = Event(duration: 10, instruction: "There are obstacles nearby!", objective: Objective.lookLeft)
                break
            }
        }
    }
    
    mutating func assignRoles() {
        for (index, _) in players.enumerated() {
            while true {
                var randomInt = -1
                
                if players.count == 3 {
                    randomInt = Int.random(in: 0...2)
                } else if players.count == 4 {
                    randomInt = Int.random(in: 0...3)
                } else {
                    randomInt = Int.random(in: 0...4)
                }
                
                switch randomInt {
                case 0:
                    players[index].role = Role.lookout
                    break
                case 1:
                    players[index].role = Role.helmsman
                    break
                case 2:
                    players[index].role = Role.sailingMaster
                    break
                case 3:
                    players[index].role = Role.cabinBoy
                    break
                default:
                    players[index].role = Role.blackSmith
                }
                
                var isRoleTaken = false
                for (_, player) in players.enumerated() {
                    if player.id != players[index].id {
                        if players[index].role == player.role {
                            isRoleTaken = true
                        }
                    }
                }
                
                if !isRoleTaken {
                    break
                }
            }
        }
    }
}
