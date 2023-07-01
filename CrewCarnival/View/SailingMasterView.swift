//
//  SailingMasterView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct SailingMasterView: View {
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
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
            Image("Sail").resizable().scaledToFill().ignoresSafeArea(.all)
            VStack{
                HStack{
                    Text("Sailing Master")
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
                }.padding(.top, 40).padding(.horizontal,30)
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
            }
        }.background(Image("BgSailingMaster").resizable().scaledToFill())
            .onAppear {
                for (index, party) in gameService.parties.enumerated() {
                    if party.id == partyId {
                        for (index2, player) in gameService.parties[index].players.enumerated() {
                            if player.role == Role.sailingMaster {
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
                            for (index2, _) in gameService.parties[index].players.enumerated() {
                                instructionProgress = gameService.parties[index].players[index2].event.duration
                            }
                        }
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
        //                                        gameService.parties[index].triggerSailingMasterEvent()
        //                                    }
        //                                } else {
        //                                    if newValue > 100 {
        //                                        gameService.parties[index].players[index2].event.instruction = "Our Front is Clear!\nQuickly Turn the Ship!"
        //                                        gameService.parties[index].triggerSailingMasterEvent()
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
        SailingMasterView(partyId: UUID())
    }
}
