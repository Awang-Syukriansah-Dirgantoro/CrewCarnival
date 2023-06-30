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
    @Binding var show: Bool
    var body: some View {
        ZStack{
            if show {
                Color.black.opacity(show ? 0.5 : 0).animation(.easeInOut(duration: 1.0)).edgesIgnoringSafeArea(.all)
                if lives > 0 {
                    Image("scenewin").resizable().frame(width: 310,height: 480).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
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
                    }.offset(y: -45)
                } else{
                    Image("scenelose").resizable().frame(width: 310,height: 480).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    HStack{
                        Image("star").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("star").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                        Image("star").scaleEffect(isAnimate ? 1.0 : 0.7).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    }.offset(y: -45)
                }
                HStack(spacing: 10){
                    Image("okrecap").resizable().frame(width: 100, height: 40).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                    Image("replayrecap").resizable().frame(width: 40, height: 40).opacity(isAnimate ? 1.0 : 0.0).animation(.easeInOut(duration: 1.0))
                }.offset(y: 155)
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isAnimate = true
                }
            }
        }
    }
}
