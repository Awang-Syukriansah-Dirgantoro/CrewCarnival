//
//  RecapSceneView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 24/06/23.
//

import SwiftUI

struct RecapSceneView: View {
    @State var lives = 2
    @State var isAnimate = false
    var body: some View {
        ZStack{
            if lives > 0 {
                Image("scenewin")
                HStack{
                    if lives == 1{
                        Image("starfill").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("star").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("star").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    } else if lives == 2{
                        Image("starfill").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("star").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    } else{
                        Image("starfill").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("starfill").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    }
                }.offset(y: -50).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            isAnimate = true
                        }
                    }
                }
                HStack(spacing: 10){
                    Image("okrecap").resizable().frame(width: 100, height: 40)
                    Image("replayrecap").resizable().frame(width: 40, height: 40)
                }.offset(y: 165)
            } else{
                Image("scenelose")
                HStack{
                    Image("star")
                    Image("star").resizable().frame(width: 80, height: 80).offset(y: -10)
                    Image("star")
                }.offset(y: -50)
                HStack(spacing: 10){
                    Image("okrecap").resizable().frame(width: 100, height: 40)
                    Image("replayrecap").resizable().frame(width: 40, height: 40)
                }.offset(y: 165)
            }
            
        }
    }
}

struct RecapSceneView_Previews: PreviewProvider {
    static var previews: some View {
        RecapSceneView()
    }
}
