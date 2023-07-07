//
//  SailingMasterView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI
import OneFingerRotation

struct SailingMasterView: View {
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    @State private var sailOneHeight: CGFloat = 112
    @State private var sailTwoHeight: CGFloat = 160
    @State private var sailThreeHeight: CGFloat = 260
    @State private var length : CGFloat = 400
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
    var partyId: UUID
    
    @State private var totalAngleOne: Double = 0.0
    @State private var totalAngleTwo: Double = 0.0
    @State private var totalAngleThree: Double = 0.0
    
    func changeHeight( sail : Double, newAngle : Double ) {
        switch sail {
        case 1:
            if totalAngleOne > newAngle {
                sailOneHeight += 0.1
                if sailOneHeight > 112 {
                    sailOneHeight = 112
                } else if sailOneHeight < 0 {
                    sailOneHeight = 0
                } else {
                    totalAngleOne = newAngle
                }
            } else {
                sailOneHeight -= 0.1
                if sailOneHeight > 112 {
                    sailOneHeight = 112
                } else if sailOneHeight < 0 {
                    sailOneHeight = 0
                } else {
                    totalAngleOne = newAngle
                }
            }
            
        case 2:
            if totalAngleTwo > newAngle {
                sailTwoHeight += 0.1
                if sailTwoHeight > 160 {
                    sailTwoHeight = 160
                } else if sailTwoHeight < 0 {
                    sailTwoHeight = 0
                } else {
                    totalAngleTwo = newAngle
                }
            } else {
                sailTwoHeight -= 0.1
                if sailTwoHeight > 160 {
                    sailTwoHeight = 160
                } else if sailTwoHeight < 0 {
                    sailTwoHeight = 0
                } else {
                    totalAngleTwo = newAngle
                }
            }
            
        case 3:
            if totalAngleThree > newAngle {
                sailThreeHeight += 0.1
                if sailThreeHeight > 260 {
                    sailThreeHeight = 260
                } else if sailThreeHeight < 0 {
                    sailThreeHeight = 0
                } else {
                    totalAngleThree = newAngle
                }
            } else {
                sailThreeHeight -= 0.1
                if sailThreeHeight > 260 {
                    sailThreeHeight = 260
                } else if sailThreeHeight < 0 {
                    sailThreeHeight = 0
                } else {
                    totalAngleThree = newAngle
                }
            }
            
        default:
            print("oke")
        }
    }
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            Image("BgSailingMaster").resizable().scaledToFill().ignoresSafeArea(.all)
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
                ZStack{
                    VStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 350, maxHeight: 112)
                            .background(
                                VStack{
                                    Image("Sail")
                                        .resizable()
                                        .frame(maxWidth: 350, maxHeight: sailOneHeight)
                                        .padding(.vertical, -5)
                                    Spacer()
                                }
                            ).offset(y:32)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 440, maxHeight: 160)
                            .background(
                                VStack{
                                    Image("Sail")
                                        .resizable()
                                        .frame(maxWidth: 440, maxHeight: sailTwoHeight)
                                        .padding(.bottom, -5)
                                    Spacer()
                                }
                            ).offset(y:32)
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(maxWidth: 590, maxHeight: 260)
                            .background(
                                VStack{
                                    Image("Sail")
                                        .resizable()
                                        .frame(maxWidth: 590, maxHeight: sailThreeHeight)
                                        .padding(.bottom, 20)
                                    Spacer()
                                }
                            ).offset(y:32)
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 390, height: 635.99042)
                        .background(
                            Image("NoSail")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 390, height: 635.9904174804688)
                                .clipped()
                        ).offset(y:32)
                    VStack{
                        Spacer()
                            .frame(height: 50)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50)
                                .valueRotation(
                                    totalAngle: $totalAngleOne,
                                    onAngleChanged: { newAngle in
                                        changeHeight(sail: 1, newAngle: newAngle)
                                    }
                                )
                        }
                        Spacer()
                            .frame(height: 80)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50).valueRotation(
                                    totalAngle: $totalAngleTwo,
                                    onAngleChanged: { newAngle in
                                        changeHeight(sail: 2, newAngle: newAngle)
                                    }
                                )
                        }
                        Spacer()
                            .frame(height: 120)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50).valueRotation(
                                    totalAngle: $totalAngleThree,
                                    onAngleChanged: { newAngle in
                                        changeHeight(sail: 3, newAngle: newAngle)
                                    }
                                )
                        }
                    }.padding(.trailing, 10)
                }
                //                Button {
                //                    for (index, party) in gameService.parties.enumerated() {
                //                        if party.id == partyId {
                //                            for (_, player) in gameService.parties[index].players.enumerated() {
                //                                if player.role == Role.sailingMaster {
                //                                    if player.event.objective == Objective.slow10 {
                //                                        gameService.parties[index].setEventCompleted(role: Role.helmsman)
                //                                        gameService.parties[index].setEventCompleted(role: Role.sailingMaster)
                //                                        gameService.send(parties: gameService.parties)
                //                                        print("cccc \(   gameService.parties[index])")
                //                                    }
                //                                }
                //                            }
                //                        }
                //                    }
                //                } label: {
                //                    Text("Slow 10 Knots")
                //                        .foregroundColor(.yellow)
                //                        .fontWeight(.bold)
                //                        .frame(
                //                            minWidth: 0,
                //                            maxWidth: .infinity
                //                        )
                //                        .padding()
                //                        .background(RoundedRectangle(cornerRadius: 15)
                //                            .fill(Color.black))
                //                        .padding(.horizontal)
                //                }
                //                Button {
                //                    for (index, party) in gameService.parties.enumerated() {
                //                        if party.id == partyId {
                //                            for (_, player) in gameService.parties[index].players.enumerated() {
                //                                if player.role == Role.sailingMaster {
                //                                    if player.event.objective == Objective.slow20 {
                //                                        gameService.parties[index].setEventCompleted(role: Role.helmsman)
                //                                        gameService.parties[index].setEventCompleted(role: Role.sailingMaster)
                //                                        gameService.send(parties: gameService.parties)
                //                                        print("cccc \(   gameService.parties[index])")
                //                                    }
                //                                }
                //                            }
                //                        }
                //                    }
                //                } label: {
                //                    Text("Slow 20 Knots")
                //                        .foregroundColor(.yellow)
                //                        .fontWeight(.bold)
                //                        .frame(
                //                            minWidth: 0,
                //                            maxWidth: .infinity
                //                        )
                //                        .padding()
                //                        .background(RoundedRectangle(cornerRadius: 15)
                //                            .fill(Color.black))
                //                        .padding(.horizontal)
                //                }
                //                Button {
                //                    for (index, party) in gameService.parties.enumerated() {
                //                        if party.id == partyId {
                //                            for (_, player) in gameService.parties[index].players.enumerated() {
                //                                if player.role == Role.sailingMaster {
                //                                    if player.event.objective == Objective.slow30 {
                //                                        gameService.parties[index].setEventCompleted(role: Role.helmsman)
                //                                        gameService.parties[index].setEventCompleted(role: Role.sailingMaster)
                //                                        gameService.send(parties: gameService.parties)
                //                                        print("cccc \(   gameService.parties[index])")
                //                                    }
                //                                }
                //                            }
                //                        }
                //                    }
                //                } label: {
                //                    Text("Slow 30 Knots")
                //                        .foregroundColor(.yellow)
                //                        .fontWeight(.bold)
                //                        .frame(
                //                            minWidth: 0,
                //                            maxWidth: .infinity
                //                        )
                //                        .padding()
                //                        .background(RoundedRectangle(cornerRadius: 15)
                //                            .fill(Color.black))
                //                        .padding(.horizontal)
                //                }
                Spacer()
            }
            .padding(.top,50)
        }
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
        .onChange(of: gameService.parties, perform: { newValue in
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    if gameService.parties[index].lives <= 0 {
                        gameService.parties[index].reset()
                        isStartGame = false
                        gameService.send(parties: gameService.parties)
                    }
                    
                    var allEventsCompleted = true
                    for (_, player) in party.players.enumerated() {
                        if !player.event.isCompleted {
                            allEventsCompleted = false
                        }
                    }
                    
                    if allEventsCompleted {
                        gameService.parties[index].generateLHSEvent()
                        for (index2, player) in gameService.parties[index].players.enumerated() {
                            if player.role == Role.sailingMaster {
                                instructionProgress = gameService.parties[index].players[index2].event.duration
                                instructionProgressMax = gameService.parties[index].players[index2].event.duration
                            }
                        }
                        gameService.send(parties: gameService.parties)
                    }
                }
            }
        })
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
        SailingMasterView(isStartGame: .constant(false), partyId: UUID()).environmentObject(GameService())
    }
}
