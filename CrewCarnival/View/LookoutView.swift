//
//  LookoutView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 22/06/23.
//

import SwiftUI

struct LookoutView: View {
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @State private var xOffset:CGFloat = 0
    @State private var isMove = false
    @State private var direction = "Forward"
    @State private var isLeftAble = true
    @State private var isRightAble = true
    @EnvironmentObject var gameService: GameService
    var partyId: UUID
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            Image("LookoutBack").resizable().scaledToFill().ignoresSafeArea(.all).offset(x:xOffset)
            VStack{
                HStack{
                    Text("Lookout")
                        .font(.custom("Gasoek One", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25, height: 19)
                            .background(
                                Image("Heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 19)
                                    .clipped()
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25, height: 19)
                            .background(
                                Image("Heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 19)
                                    .clipped()
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 25, height: 19)
                            .background(
                                Image("Heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 19)
                                    .clipped()
                            )
                    }
                }.padding(.bottom).padding(.horizontal,30)
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 334, height: 27)
                        .background(
                            Image("LoadingBar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 334, height: 27)
                                .clipped()
                        )
                    ProgressView("", value: partyProgress, total: 100).progressViewStyle(gradientStyle).padding(.horizontal,9)
                        .onReceive(timer) { _ in
                            if partyProgress < 100 {
                                partyProgress += 2
                            }
                        }
                }.padding(.bottom,20).padding(.horizontal,30)
                    ZStack{
                        Rectangle().frame(height: 60).opacity(0.5)
                        ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                            if party.id == partyId {
                                ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                    if gameService.currentPlayer.id == player.id {
                                        Text("\(gameService.parties[index].players[index2].event.instruction)")
                                            .font(Font.custom("Gasoek One", size: 20))
                                            .multilineTextAlignment(.center)
                                            .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                                    }
                                }
                            }
                        }
                        ProgressView("", value: instructionProgress, total: instructionProgressMax).progressViewStyle(gradientStyle).padding(.horizontal,9)
                            .onReceive(timer) { _ in
                                if instructionProgress > 0 {
                                    instructionProgress -= 0.1
                                }
                            }.frame(width: 400 ,height: 60,alignment:.bottom).ignoresSafeArea(.all)
                    }
                Spacer()
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 247, height: 66)
                        .background(
                            Image("InfoBox")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 247, height: 66)
                                .clipped()
                        )
                    Text("You are looking at: \(direction) Direction")
                        .font(Font.custom("Krub-Regular", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white).frame(width: 247, height: 66)
                }
                HStack{
                    Spacer()
                    Button{
                        isMove = true
                        isLeftAble = false
                        isRightAble = false
                        withAnimation (Animation.easeOut (duration: 3)){
                            xOffset = xOffset + 393
                        }
                        if xOffset == 0 {
                            direction = "Forward"
                            isLeftAble = true
                            isRightAble = true
                        } else {
                            direction = "Left"
                            isLeftAble = false
                            isRightAble = true
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 125.51723, height: 129.99998)
                            .background(
                                Image("ButtonLeft")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 125.5172348022461, height: 129.99998474121094)
                                    .clipped()
                            )
                    }.disabled(!isLeftAble)
                    Spacer()
                    Button{
                        isMove = true
                        isLeftAble = false
                        isRightAble = false
                        withAnimation (Animation.easeOut (duration: 3)){
                            xOffset = xOffset - 393
                        }
                        if xOffset == 0 {
                            direction = "Forward"
                            isLeftAble = true
                            isRightAble = true
                        } else {
                            direction = "Right"
                            isLeftAble = true
                            isRightAble = false
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 125.51723, height: 129.99998)
                            .background(
                                Image("ButtonRight")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 125.5172348022461, height: 129.99998474121094)
                                    .clipped()
                            )
                    }.disabled(!isRightAble)
                    Spacer()
                }
            }
            .padding(.vertical,50)
        }
        .onAppear {
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.lookout {
                            print("pr: \(player.event.instruction)")
                            instructionProgress = gameService.parties[index].players[index2].event.duration
                            instructionProgressMax = gameService.parties[index].players[index2].event.duration
                        }
                    }
                }
            }
        }
        .onChange(of: gameService.parties) { newDirection in
            print("ddd: \(gameService.parties)")
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.lookout {
                            print("dddp: \(player)")
//                            if player.event.objective == Objective.lookLeft {
//                                if newDirection == "Left" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Left is Clear!\nQuickly Turn the Ship!"
//                                    gameService.parties[index].triggerHelmsmanEvent()
//                                }
//                            } else if player.event.objective == Objective.lookRight {
//                                if newDirection == "Right" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Right is Clear!\nQuickly Turn the Ship!"
//                                    gameService.parties[index].triggerHelmsmanEvent()
//                                }
//                            } else {
//                                if newDirection == "Front" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Front is Clear!\nQuickly Turn the Ship!"
//                                    gameService.parties[index].triggerHelmsmanEvent()
//                                }
//                            }
                        }
                    }
                }
            }
        }
    }
}

struct LookoutView_Previews: PreviewProvider {
    static var previews: some View {
        LookoutView(partyId: UUID())
            .environmentObject(GameService())
    }
}
