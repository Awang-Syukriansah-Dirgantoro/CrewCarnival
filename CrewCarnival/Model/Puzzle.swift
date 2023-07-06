//
//  Puzzle.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 27/06/23.
//

import UIKit

struct Puzzle: Identifiable, Hashable,Equatable {
    var id = UUID().uuidString
    var value: String
    var padding: CGFloat = 10
    var offset_x: CGFloat
    var offset_y: CGFloat
    var width: CGFloat
    var height: CGFloat
    var textSize: CGFloat = .zero
    var fontSize: CGFloat = 19
    var isShowing: Bool = false
    
}
