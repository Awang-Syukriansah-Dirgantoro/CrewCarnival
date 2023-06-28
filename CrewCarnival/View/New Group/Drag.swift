//
//  Drag.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 27/06/23.
//

import SwiftUI

struct Drag: View {
    
    @ObservedObject var vm : PuzzleViewModel
   
    var body: some View {
        VStack(spacing:12) {
            ForEach($vm.shuffledRows, id: \.self) { $row in
                HStack(spacing:10) {
                    ForEach($row) { $item in
                        Image(item.value)
                            .resizable()
                            .scaledToFit()
                            .padding(15)
                            .onDrag {
                                return .init(contentsOf:URL(string:item.id))!
                            }
                            
                            .opacity(item.isShowing ? 0 : 1)
                    }
                }
                if vm.shuffledRows.last != row {
                    Divider()
                }
            }
        }
    }
}

struct DragView_Previews: PreviewProvider {
    static var previews: some View {
        Drag(vm: PuzzleViewModel())
    }
}
