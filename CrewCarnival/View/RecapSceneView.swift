//
//  RecapSceneView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 24/06/23.
//

import SwiftUI

struct RecapSceneView: View {
    @State var lives = 0
    var body: some View {
        ZStack{
            if lives > 0 {
                Image("scenewin")
                HStack{
                    if lives == 1{
                        Image("starfill")
                        Image("star").resizable().frame(width: 80, height: 80).offset(y: -10)
                        Image("star")
                    } else if lives == 2{
                        Image("starfill")
                        Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10)
                        Image("star")
                    } else{
                        Image("starfill")
                        Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10)
                        Image("starfill")
                    }
                }.offset(y: -50)
            } else{
                Image("scenelose")
                HStack{
                    Image("star")
                    Image("star").resizable().frame(width: 80, height: 80).offset(y: -10)
                    Image("star")
                }.offset(y: -50)
            }
            
        }
    }
}

struct RecapSceneView_Previews: PreviewProvider {
    static var previews: some View {
        RecapSceneView()
    }
}
