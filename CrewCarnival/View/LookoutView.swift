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
    @State private var xOffset:CGFloat = -391
    @State private var isMove = false
    @State private var direction = "Forward"
    @State private var isLeftAble = true
    @State private var isRightAble = true
    @State private var listView = ["ViewRight","ViewForward","ViewLeft"]
    @State private var views = ""
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    var partyId: UUID
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            GeometryReader { geometry in
                Image(views).resizable().scaledToFill().ignoresSafeArea(.all).offset(x:xOffset)
            }
            VStack{
                HStack{
                    Text("Lookout")
                        .font(.custom("Gasoek One", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                            if party.id == partyId {
                                if party.lives > 0 {
                                    ForEach((0...party.lives - 1), id: \.self) { _ in
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
                                }
                            }
                        }
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
                                partyProgress += 0.1
                            }
                        }
                }.padding(.bottom,20).padding(.horizontal,30)
                VStack{
                    ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                        if party.id == partyId {
                            ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                if gameService.currentPlayer.id == player.id {
                                    Text("\(player.event.instruction)")
                                        .font(Font.custom("Gasoek One", size: 20))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 20)
                                        .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                                        .background(
                                            Rectangle()
                                                .opacity(0.5))
                                }
                            }
                        }
                    }
                    ProgressView("", value: instructionProgress, total: instructionProgressMax)
                        .onReceive(timer) { _ in
                            if instructionProgress > 0 {
                                instructionProgress -= 0.1
                            }
                        }
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0, green: 0.82, blue: 0.23)))
                        .padding(.top, -30)
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
                        if xOffset == -391 {
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
                        if xOffset == -391 {
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
            views = listView.randomElement()!
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.lookout {
                            instructionProgress = gameService.parties[index].players[index2].event.duration
                            instructionProgressMax = gameService.parties[index].players[index2].event.duration
                        }
                    }
                }
            }
        }
        .onChange(of: instructionProgress, perform: { newValue in
            if instructionProgress <= 0 {
                for (index, party) in gameService.parties.enumerated() {
                    if party.id == partyId {
                        gameService.parties[index].generateLHSEvent()
                        if party.lives > 0 {
                            gameService.parties[index].lives -= 1
                        }
                        gameService.send(parties: gameService.parties)
                        if gameService.parties[index].lives <= 0 {
                            gameService.parties[index].reset()
                            gameService.send(parties: gameService.parties)
                            isStartGame = false
                        }
                        
                        for (index2, _) in gameService.parties[index].players.enumerated() {
                            instructionProgress = gameService.parties[index].players[index2].event.duration
                        }
                    }
                }
            }
        })
        .onChange(of: direction) { newDirection in
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.lookout {
                            if player.event.objective == Objective.lookLeft {
                                if newDirection == "Left" {
                                    gameService.parties[index].players[index2].event.instruction = "Our Left is Clear!\nQuickly Turn the Ship!"
                                    gameService.parties[index].triggerHelmsmanEvent()
                                }
                            } else if player.event.objective == Objective.lookRight {
                                if newDirection == "Right" {
                                    gameService.parties[index].players[index2].event.instruction = "Our Right is Clear!\nQuickly Turn the Ship!"
                                    gameService.parties[index].triggerHelmsmanEvent()
                                }
                            } else {
                                if newDirection == "Front" {
                                    gameService.parties[index].players[index2].event.instruction = "Our Front is Clear!\nQuickly Turn the Ship!"
                                    gameService.parties[index].triggerHelmsmanEvent()
                                }
                            }
                            gameService.send(parties: gameService.parties)
                        }
                    }
                }
            }
        }
    }
}

struct LookoutView_Previews: PreviewProvider {
    static var previews: some View {
        LookoutView(isStartGame: .constant(false), partyId: UUID())
            .environmentObject(GameService())
    }
}
