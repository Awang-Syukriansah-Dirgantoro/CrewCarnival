//
//  RecapSceneView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 24/06/23.
//

import SwiftUI

struct RecapSceneView: View {
    @Binding var lives: Int
    @State var scaleEff = 0.7
    @State var isAnimate = 0.0
    @EnvironmentObject var gameService: GameService
    @Binding var show: Bool
    @Binding var isStartGame: Bool
    var body: some View {
        ZStack{
            if show {
                Color.black.opacity(show ? 0.6 : 0).edgesIgnoringSafeArea(.all)
                if lives > 0 {
                    Image("scenewin").resizable().frame(width: 310,height: 480).opacity(isAnimate)
                    HStack{
                        if lives == 1{
                            Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                            Image("star").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(scaleEff).opacity(isAnimate)
                            Image("star").scaleEffect(scaleEff).opacity(isAnimate)
                        } else if lives == 2{
                            Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                            Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(scaleEff).opacity(isAnimate)
                            Image("star").scaleEffect(scaleEff).opacity(isAnimate)
                        } else{
                            Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                            Image("starfill").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(scaleEff).opacity(isAnimate)
                            Image("starfill").scaleEffect(scaleEff).opacity(isAnimate)
                        }
                    }.offset(y: -45)
                } else{
                    Image("scenelose").resizable().frame(width: 310,height: 480).opacity(isAnimate)
                    HStack{
                        Image("star").scaleEffect(scaleEff).opacity(isAnimate)
                        Image("star").resizable().frame(width: 80, height: 80).offset(y: -10).scaleEffect(scaleEff).opacity(isAnimate)
                        Image("star").scaleEffect(scaleEff).opacity(isAnimate)
                    }.offset(y: -45)
                }
                HStack(spacing: 10){
                    Button {
                        gameService.party.reset()
//                        gameService.send(party: gameService.party)
                        isStartGame = false
                    } label: {
                        Image("okrecap").resizable().frame(width: 100, height: 40).opacity(isAnimate)
                    }
                    
//                    Button {
//                        for (index, party) in gameService.parties.enumerated() {
//                            if party.id == partyId {
//                                gameService.parties[index].reset()
//                                gameService.send(parties: gameService.parties)
//
//                            }
//                        }
//                    } label: {
//                        Image("replayrecap").resizable().frame(width: 40, height: 40).opacity(isAnimate)
//                    }
                    
                }.offset(y: 155)
            }
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    scaleEff = 1.0
                    isAnimate = 1.0
                }
            }
        }
    }
}



