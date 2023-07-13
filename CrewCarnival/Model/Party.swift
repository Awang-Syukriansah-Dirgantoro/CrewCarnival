//
//  Party.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import Foundation

struct Party: Codable, Identifiable, Equatable {
    static func == (lhs: Party, rhs: Party) -> Bool {
        return lhs.players == rhs.players && lhs.isPlaying == rhs.isPlaying && lhs.lives == rhs.lives && lhs.partyProg == rhs.partyProg && lhs.flashred == rhs.flashred && lhs.popup == rhs.popup
    }
    
    var id = UUID()
    var players = [Player]()
    var isPlaying = false
    var lives = 3
    var partyProg = 0.0
    var flashred = false
    var popup = false
    var chose = false
    var isSideEvent = false
    
    mutating func generateLHSEvent() {
        var randomInt = Int.random(in: 0...1)
        
        for (index, player) in players.enumerated() {
            if player.role == Role.lookout {
                var objective = Objective.lookLeft
                
                switch randomInt {
                case 0:
                    objective = Objective.lookLeft
                    break
                default:
                    objective = Objective.lookRight
                }
                
                players[index].event = Event(duration: 15, instruction: "There are obstacles nearby!", objective: objective)
            }
            
            if player.role == Role.helmsman {
                var objective = Objective.turnLeft
                
                switch randomInt {
                case 0:
                    objective = Objective.turnLeft
                    break
                default:
                    objective = Objective.turnRight
                }
                
                players[index].event = Event(duration: 15, instruction: "There are obstacles nearby!", objective: objective)
            }
            
            if player.role == Role.sailingMaster {
                randomInt = Int.random(in: 0...2)
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
                
                players[index].event = Event(duration: 15, instruction: "There are obstacles nearby!", objective: objective)
            }
            if player.role == Role.blackSmith {
                randomInt = Int.random(in: 0...2)
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
                
                players[index].event = Event(duration: 15, instruction: "Drag and fix the object", objective: objective, isCompleted: false)
            }
//            if player.role == Role.cabinBoy {
////                let randomInt = Int.random(in: 0...2)
//                var randomInt = 0
//                var objective = Objective.sail
//
//                switch randomInt {
//                case 0:
//                    objective = Objective.sail
//                    break
//                case 1:
//                    objective = Objective.steer
//                    break
//                case 2:
//                    objective = Objective.binocular
//                    break
//
//                default:
//                    objective = Objective.sail
//                }
//                players[index].event = Event(duration: 10, instruction: "Team mate need your help!", objective: objective)
//            }
        }
    }
    
    mutating func generateSideEvent(){
        for (index, player) in players.enumerated() {
            if player.role == Role.cabinBoy {
                let randomInt = Int.random(in: 0...2)
//                var randomInt = 0
                var objective = Objective.sail
                
                switch randomInt {
                case 0:
                    objective = Objective.sail
                    break
                case 1:
                    objective = Objective.steer
                    break
                case 2:
                    objective = Objective.binocular
                    break
                    
                default:
                    objective = Objective.sail
                }
                players[index].event = Event(duration: 15, instruction: "Team mate need your help!", objective: objective)
            }
            
            if player.role == Role.sailingMaster {
//                let randomInt = Int.random(in: 0...2)
                var randomInt = 0
                var objective = Objective.sail
                
                switch randomInt {
                case 0:
                    objective = Objective.sail
                    break
                    
                default:
                    objective = Objective.sail
                }
                players[index].event = Event(duration: 15, instruction: "Ohh nooo, sail is broke!", objective: objective)
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
    
    mutating func setClick() {
        chose = true
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
    
    mutating func reset() {
        for (index, _) in self.players.enumerated() {
            self.players[index].isReady = false
            self.players[index].role = nil
            self.players[index].isSkipStory = false
        }
        
        self.lives = 3
        self.partyProg = 0.0
        self.popup = false
        assignRoles()
    }
}
