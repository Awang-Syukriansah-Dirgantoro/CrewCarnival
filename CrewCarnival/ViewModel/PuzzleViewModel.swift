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
    
    @Published var progress : CGFloat = 0
    @Published var shuffledRows: [[Puzzle]] = []
    @Published var rows: [[Puzzle]] = []
    
    @Published var animateWrong = false
    @Published var droppedCount: CGFloat = 0
 
    func generateGrid() -> [[Puzzle]] {
        var gridArray: [[Puzzle]] = []
        var tempArray: [Puzzle] = []
        var currentWidth: CGFloat = 0
        let totalScreenWidth:CGFloat = CGFloat(UIScreen.main.bounds.width - 30)
        
        for steer in steers {
            if currentWidth < totalScreenWidth {
                tempArray.append(steer)
            }else {
                gridArray.append(tempArray)
                tempArray = []
                tempArray.append(steer)
            }
        }
        
        if !tempArray.isEmpty {
            gridArray.append(tempArray)
        }
        
        return gridArray
        
    }
    
    func shuffleArray() {
        if rows.isEmpty {
            rows =  generateGrid()
            steers =  steers.shuffled()
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
