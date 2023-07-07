//
//  SailingMasterView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct SailingMasterView: View {
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    @State private var angle1: CGFloat = 123
    @State private var lastAngle1: CGFloat = 0
    @State private var length : CGFloat = 400
    @State private var angle2: CGFloat = 0
    @State private var lastAngle2: CGFloat = 0
    @State private var angle3: CGFloat = 0
    @State private var lastAngle3: CGFloat = 0
    @State private var offset = CGSize.zero
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            VStack{
                HStack{
                    Text("Sailing Master")
                        .font(.custom("Gasoek One", size: 24))
                        .foregroundColor(.white)
                    Spacer()
                    HStack {
                        if gameService.party.lives > 0 {
                            ForEach((0...gameService.party.lives - 1), id: \.self) { _ in
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
                        .onReceive(timer) { _ in
                            if partyProgress < 100 {
                                partyProgress += 0.1
                            }
                        }
                }.padding(.bottom,20).padding(.horizontal,30)
                VStack{
                    ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
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
                    ProgressView("", value: instructionProgress, total: instructionProgressMax)
                        .onReceive(timer) { _ in
                            if instructionProgress > 0 {
                                instructionProgress -= 0.1
                            }
                        }
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0, green: 0.82, blue: 0.23)))
                        .padding(.top, -30)
                }
                // ZStack{
                //     VStack{
                //         Image("Sail")
                //             .resizable()
                //             .frame(maxWidth: 350, maxHeight: self.angle1)
                //             .padding(.vertical, -5)
                //         Image("Sail")
                //             .resizable()
                //             .frame(maxWidth: 440, maxHeight: 160)
                //             .padding(.bottom, -5)
                //         Image("Sail")
                //             .resizable()
                //             .frame(maxWidth: 590, maxHeight: 260)
                //             .padding(.bottom, 20)
                //     }
                //     Image("NoSail")
                //         .resizable()
                //         .scaledToFill()
                //         .padding(-38)
                //     VStack{
                //         Spacer()
                //             .frame(height: 50)
                //         ZStack{
                //             Image("Tuas2")
                //                 .resizable()
                //                 .frame(width: 60, height: 60)
                //             Image("Tuas1")
                //                 .resizable()
                //                 .frame(width: 24, height: 63)
                //                 .padding(.bottom, 50)
                //                 .rotationEffect(.degrees(Double(self.angle1)))
                //                 .gesture(DragGesture()
                //                     .onChanged{ v in
                //                         let theta = (atan2(v.location.x - self.length / 5, self.length / 5 - v.location.y) - atan2(v.startLocation.x - self.length / 5, self.length / 5 - v.startLocation.y)) * 360 / .pi
                //                         print(self.angle1)
                //                         self.angle1 = theta + self.lastAngle1
                //                     }
                //                     .onEnded { v in
                //                         self.lastAngle1 = self.angle1
                //                     }
                //                 )
                //         }
                //         Spacer()
                //             .frame(height: 80)
                //         ZStack{
                //             Image("Tuas2")
                //                 .resizable()
                //                 .frame(width: 60, height: 60)
                //             Image("Tuas1")
                //                 .resizable()
                //                 .frame(width: 24, height: 63)
                //                 .padding(.bottom, 50)
                //                 .rotationEffect(.degrees(Double(self.angle2)))
                //                 .gesture(DragGesture()
                //                     .onChanged{ v in
                //                         var theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                //                         if (theta < 0) { theta += 360 }
                //                         self.angle2 = theta + self.lastAngle2
                //                     }
                //                     .onEnded { v in
                //                         self.lastAngle2 = self.angle2
                //                     }
                //                 )
                //         }
                //         Spacer()
                //             .frame(height: 120)
                //         ZStack{
                //             Image("Tuas2")
                //                 .resizable()
                //                 .frame(width: 60, height: 60)
                //             Image("Tuas1")
                //                 .resizable()
                //                 .frame(width: 24, height: 63)
                //                 .padding(.bottom, 50)
                //                 .rotationEffect(.degrees(Double(self.angle3)))
                //                 .gesture(DragGesture()
                //                     .onChanged{ v in
                //                         var theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                //                         if (theta < 0) { theta += 360 }
                //                         self.angle3 = theta + self.lastAngle3
                //                     }
                //                     .onEnded { v in
                //                         self.lastAngle3 = self.angle3
                //                     }
                //                 )
                //         }
                //     }.padding(.trailing, 10)
                // }
                Button {
                    for (_, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow10 {
                                gameService.party.setEventCompleted(role: Role.helmsman)
                                gameService.party.setEventCompleted(role: Role.sailingMaster)
                                gameService.send(party: gameService.party)
                                print("cccc \(   gameService.party)")
                            }
                        }
                    }
                } label: {
                    Text("Slow 10 Knots")
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black))
                        .padding(.horizontal)
                }
                Button {
                    for (_, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow20 {
                                gameService.party.setEventCompleted(role: Role.helmsman)
                                gameService.party.setEventCompleted(role: Role.sailingMaster)
                                gameService.send(party: gameService.party)
                                print("cccc \(   gameService.party)")
                            }
                        }
                    }
                } label: {
                    Text("Slow 20 Knots")
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black))
                        .padding(.horizontal)
                }
                Button {
                    for (_, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow30 {
                                gameService.party.setEventCompleted(role: Role.helmsman)
                                gameService.party.setEventCompleted(role: Role.sailingMaster)
                                gameService.send(party: gameService.party)
                                print("cccc \(   gameService.party)")
                            }
                        }
                    }
                } label: {
                    Text("Slow 30 Knots")
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black))
                        .padding(.horizontal)
                }
                Spacer()
            }
        }.background(Image("BgSailingMaster").resizable().scaledToFill())
            .onAppear {
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.sailingMaster {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
                }
            }
            .onChange(of: gameService.party, perform: { newValue in
                if gameService.party.lives <= 0 {
                    gameService.party.reset()
                    isStartGame = false
                    gameService.send(party: gameService.party)
                }
                
                var allEventsCompleted = true
                for (_, player) in gameService.party.players.enumerated() {
                    if !player.event.isCompleted {
                        allEventsCompleted = false
                    }
                }
                
                if allEventsCompleted {
                    gameService.party.generateLHSEvent()
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
                        }
                    }
                    gameService.send(party: gameService.party)
                }
            })
            .onChange(of: instructionProgress, perform: { newValue in
                if instructionProgress <= 0 {
                    for (index, _) in gameService.party.players.enumerated() {
                        instructionProgress = gameService.party.players[index].event.duration
                    }
                }
            })
        //            .onChange(of: progress) { newValue in
        //                print(progress)
        //                for (index, party) in gameService.parties.enumerated() {
        //                    if party.id == partyId {
        //                        for (index2, player) in gameService.parties[index].players.enumerated() {
        //                            if player.role == Role.sailingMaster {
        //                                if player.event.objective == Objective.turnLeft {
        //                                    if newValue < -100 {
        //                                        gameService.parties[index].players[index2].event.instruction = "Our Left is Clear!\nQuickly Turn the Ship!"
        //                                        gameService.parties[index].triggerSailingMasterInstruction()
        //                                    }
        //                                } else {
        //                                    if newValue > 100 {
        //                                        gameService.parties[index].players[index2].event.instruction = "Our Front is Clear!\nQuickly Turn the Ship!"
        //                                        gameService.parties[index].triggerSailingMasterInstruction()
        //                                    }
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //            }
    }
}

struct SailingMasterView_Previews: PreviewProvider {
    static var previews: some View {
        SailingMasterView(isStartGame: .constant(false)).environmentObject(GameService())
    }
}
