//
//  HelmsmanView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 21/06/23.
//

import SwiftUI

struct HelmsmanView: View {
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @EnvironmentObject var gameService: GameService
    var partyId: UUID
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @State private var progress: CGFloat = 0
    @State private var angle: CGFloat = 0
    @State private var lastAngle: CGFloat = 0
    @State private var length : CGFloat = 400
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        NavigationStack{
            ZStack {
                Image("ShipHelmsman").resizable().scaledToFill().ignoresSafeArea(.all)
                VStack{
                    HStack{
                        Text("Helmsman")
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
                    }.padding(.horizontal, 30)
                        .padding(.top, 10)
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
                    }.padding(.bottom,20).padding(.horizontal,30)
                    
                    VStack{
                        ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                            if party.id == partyId {
                                ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                    if gameService.currentPlayer.id == player.id {
                                        Text("The Ship Is Tilting, Slow\nDown 10 Knots!")
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
                    Image("StearingWheel")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .rotationEffect(
                            .degrees(Double(self.angle)))
                        .gesture(DragGesture()
                            .onChanged{ v in
                                let theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                                self.angle = theta + self.lastAngle
                                print(self.angle)
                                
                                if (self.angle > 300){
                                    self.angle = 300
                                    self.progress = self.angle
                                } else if (self.angle < 0){
                                    if (self.angle < -300){
                                        self.angle = -300
                                        self.progress = 300
                                    } else {
                                        self.progress = self.angle * (-1)
                                    }
                                }
                                else {
                                    self.progress = self.angle
                                }
                                print(self.angle)
                            }
                            .onEnded { v in
                                self.lastAngle = self.angle
                            }
                        )
                        .offset(y: 150)
        
                    Spacer()
                        .frame(height: 180)
                    VStack{
                        Text("Turn Progress")
                            .font(Font.custom("Krub-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 32)
                            .background(Image("BgTurnProgress")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 125, height: 32)
                                .clipped())
                            .cornerRadius(15)
                            .padding(.bottom, -15)
                        ProgressBar(progress: self.progress)
                    }
                }
            }.background(Image("BgHelmsman").resizable().scaledToFit())
        }
        .onAppear {
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.helmsman {
                            instructionProgress = gameService.parties[index].players[index2].event.duration
                            instructionProgressMax = gameService.parties[index].players[index2].event.duration
                        }
                    }
                }
            }
        }
//        .onChange(of: direction) { newDirection in
//            for (index, party) in gameService.parties.enumerated() {
//                if party.id == partyId {
//                    for (index2, player) in gameService.parties[index].players.enumerated() {
//                        if player.role == Role.helmsman {
//                            if player.event.objective == Objective.lookLeft {
//                                if newDirection == "Left" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Left is Clear!\nQuickly Turn the Ship!"
//                                }
//                            } else if player.event.objective == Objective.lookRight {
//                                if newDirection == "Right" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Right is Clear!\nQuickly Turn the Ship!"
//                                }
//                            } else {
//                                if newDirection == "Front" {
//                                    gameService.parties[index].players[index2].event.instruction = "Our Front is Clear!\nQuickly Turn the Ship!"
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
}

struct HelmsmanView_Previews: PreviewProvider {
    static var previews: some View {
        HelmsmanView(partyId: UUID())
    }
}
