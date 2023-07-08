//
//  PuzzleViewModel.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 27/06/23.
//

import SwiftUI

class PuzzleViewModel:NSObject, ObservableObject {
    @Published var steers: [Puzzle] = [Puzzle(value: "Steer1", offset_x: 0, offset_y: -50, width: 100, height: 100),
                                       Puzzle(value: "Steer2", offset_x: -75, offset_y: 0, width: 50, height: 155),
                                       Puzzle(value: "Steer3", offset_x: 75, offset_y: 0, width: 50, height: 155),
                                       Puzzle(value: "Steer4", offset_x: 0, offset_y: 50, width: 100, height: 100)]
    
    @Published var sails: [Puzzle] = [Puzzle(value: "Sail1", offset_x: -76, offset_y: 62.5, width: 145, height: 65),
                                       Puzzle(value: "Sail2", offset_x: 75, offset_y: 62, width: 157, height: 65),
                                       Puzzle(value: "Sail3", offset_x: 75, offset_y: 0, width: 157, height: 59),
                                       Puzzle(value: "Sail4", offset_x: -76, offset_y: 0, width: 145, height: 60)]
    
    @Published var binoculars: [Puzzle] = [Puzzle(value: "Binocular1", offset_x: -89, offset_y: 0, width: 103, height: 85),
                                       Puzzle(value: "Binocular2", offset_x: 0, offset_y: 0, width: 75, height: 85),
                                           Puzzle(value: "Binocular3", offset_x: 89, offset_y: 0, width: 103, height: 98)]
    
    @Published var progress : CGFloat = 0
    @Published var event = ["steer", "sail", "binocular"]
    @Published var randomEvent: String?
    @Published var shuffledRows: [[Puzzle]] = []
    @Published var rows: [[Puzzle]] = []
    
    @Published var animateWrong = false
    @Published var droppedCount: CGFloat = 0
 
    func generateGrid() -> [[Puzzle]] {
        var gridArray: [[Puzzle]] = []
        var tempArray: [Puzzle] = []
        var currentWidth: CGFloat = 0
        let totalScreenWidth:CGFloat = CGFloat(UIScreen.main.bounds.width - 30)
        
        if randomEvent == "steer"{
            for steer in steers {
                if currentWidth < totalScreenWidth {
                    tempArray.append(steer)
                }else {
                    gridArray.append(tempArray)
                    tempArray = []
                    tempArray.append(steer)
                }
            }
        }
        else if randomEvent == "sail"{
            for sail in sails {
                if currentWidth < totalScreenWidth {
                    tempArray.append(sail)
                }else {
                    gridArray.append(tempArray)
                    tempArray = []
                    tempArray.append(sail)
                }
            }
        }
        else {
            for binocular in binoculars {
                if currentWidth < totalScreenWidth {
                    tempArray.append(binocular)
                }else {
                    gridArray.append(tempArray)
                    tempArray = []
                    tempArray.append(binocular)
                }
            }
        }
        
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
        
    }
    
    func shuffleEvent() {
        randomEvent = event.randomElement()
    }
    
    func shuffleArray() {
        if rows.isEmpty {
            rows =  generateGrid()
            if randomEvent == "steer"{
                steers =  steers.shuffled()
            } else if randomEvent == "sail" {
                sails =  sails.shuffled()
            } else{
                binoculars =  binoculars.shuffled()
            }
            shuffledRows =  generateGrid()
        }
    }
    
    func updateSuffledArray(character:Puzzle) {
        for index in shuffledRows.indices {
            for subIndex in shuffledRows[index].indices {
                if shuffledRows[index][subIndex].id == character.id {
                    shuffledRows[index][subIndex].isShowing = true
                }
            }
        }
    }
}
