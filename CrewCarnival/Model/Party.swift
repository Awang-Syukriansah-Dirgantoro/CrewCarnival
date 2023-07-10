//
//  Party.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import Foundation

struct Party: Codable, Identifiable, Equatable {
    static func == (lhs: Party, rhs: Party) -> Bool {
        return lhs.players == rhs.players && lhs.isPlaying == rhs.isPlaying && lhs.lives == rhs.lives
    }
    
    var id = UUID()
    var players = [Player]()
    var isPlaying = false
    var lives = 3
    
    mutating func generateLHSEvent() {
        for (index, player) in players.enumerated() {
            if player.role == Role.lookout {
//                while true {
//                    var randomInt = Int.random(in: 0...2)
                    var randomInt = 0
                    var objective = Objective.lookLeft
                    
                    switch randomInt {
                    case 0:
                        objective = Objective.lookLeft
                        break
                    case 1:
                        objective = Objective.lookFront
                        break
                    default:
                        objective = Objective.lookRight
                    }
                    
//                    if player.event.objective != objective {
                        players[index].event = Event(duration: 30, instruction: "There are obstacles nearby!", objective: objective)
//                        break
//                    }
//                }
            }
            
            if player.role == Role.helmsman {
//                var randomInt = Int.random(in: 0...1)
                var randomInt = 0
                var objective = Objective.turnLeft
                
                switch randomInt {
                case 0:
                    objective = Objective.turnLeft
                    break
                default:
                    objective = Objective.turnRight
                }
                
                players[index].event = Event(duration: 30, instruction: "There are obstacles nearby!", objective: objective)
            }
            
            if player.role == Role.sailingMaster {
                var randomInt = Int.random(in: 0...2)
                var objective = Objective.slow10
                
                switch randomInt {
                case 0:
                    objective = Objective.slow10
                    break
                case 1:
                    objective = Objective.slow20
                    break
                default:
                    objective = Objective.slow30
                }
                
                players[index].event = Event(duration: 30, instruction: "There are obstacles nearby!", objective: objective)
            }
            if player.role == Role.blackSmith {
                var randomInt = Int.random(in: 0...2)
                var objective = Objective.steer
                
                switch randomInt {
                case 0:
                    objective = Objective.sail
                    break
                case 1:
                    objective = Objective.binocular
                    break
                case 2:
                    objective = Objective.steer
                    break
                default:
                    objective = Objective.steer
                }
                
                players[index].event = Event(duration: 30, instruction: "Drag and fix the object", objective: objective, isCompleted: false)
            }
        }
    }
    
    mutating func setEventCompleted(role: Role) {
        for (index, player) in players.enumerated() {
            if player.role == role {
                players[index].event.isCompleted = true
            }
        }
    }
    
//    mutating func triggerHelmsmanInstruction() {
//        for (index, player) in players.enumerated() {
//            if player.role == Role.helmsman {
//                players[index].event.instruction = "aaabh"
//            }
//        }
//    }
//
//    mutating func triggerSailingMasterInstruction() {
//        for (index, player) in players.enumerated() {
//            if player.role == Role.sailingMaster {
//                players[index].event.instruction = "dddd"
//            }
//        }
//    }
    
    mutating func assignRoles() {
        for (index, _) in players.enumerated() {
            while true {
                var randomInt = -1
                
                if players.count <= 3 {
                    randomInt = Int.random(in: 0...2)
                } else if players.count <= 4 {
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
                    players[index].role = Role.blackSmith
                    break
                default:
                    players[index].role = Role.cabinBoy
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
    
    mutating func reset() {
        self.isPlaying = false
        self.lives = 3
        
        for (index, _) in self.players.enumerated() {
            self.players[index].isReady = false
            self.players[index].role = nil
        }
        
        assignRoles()
    }
}
