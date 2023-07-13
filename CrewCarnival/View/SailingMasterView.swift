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
    @State private var showPopUp: Bool = false
    @State private var lives = 0
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var roleExplain = false
    @State var timeExplain = 7.9
    @State var showSuccessOverlay = false
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    @State var eventblacksmith = false
    @State private var isSlowProgressCompleted: Objective?
    @State private var totalAngleOne: Double = 0.0
    @State private var totalAngleTwo: Double = 0.0
    @State private var totalAngleThree: Double = 0.0
    
    func changeHeight( sail : Double, newAngle : Double ) {
        switch sail {
        case 1:
            if totalAngleOne > newAngle {
                sailOneHeight += 1.5
                if sailOneHeight > 112 {
                    sailOneHeight = 112
                } else if sailOneHeight < 0 {
                    sailOneHeight = 0
                } else {
                    totalAngleOne = newAngle
                }
            } else {
                sailOneHeight -= 1.5
                if sailOneHeight > 112 {
                    sailOneHeight = 112
                } else if sailOneHeight < 0 {
                    sailOneHeight = 0
                    for player in gameService.party.players {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow10 {
                                isSlowProgressCompleted = Objective.slow10
                                break
                            }
                        }
                    }
                } else {
                    totalAngleOne = newAngle
                }
            }
        case 2:
            if totalAngleTwo > newAngle {
                sailTwoHeight += 1.5
                if sailTwoHeight > 160 {
                    sailTwoHeight = 160
                } else if sailTwoHeight < 0 {
                    sailTwoHeight = 0
                } else {
                    totalAngleTwo = newAngle
                }
            } else {
                sailTwoHeight -= 1.5
                if sailTwoHeight > 160 {
                    sailTwoHeight = 160
                } else if sailTwoHeight < 0 {
                    sailTwoHeight = 0
                    for player in gameService.party.players {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow20 {
                                isSlowProgressCompleted = Objective.slow20
                                break
                            }
                        }
                    }
                } else {
                    totalAngleTwo = newAngle
                }
            }
            
        case 3:
            if totalAngleThree > newAngle {
                sailThreeHeight += 1.5
                if sailThreeHeight > 260 {
                    sailThreeHeight = 260
                } else if sailThreeHeight < 0 {
                    sailThreeHeight = 0
                } else {
                    totalAngleThree = newAngle
                }
            } else {
                sailThreeHeight -= 1.5
                if sailThreeHeight > 260 {
                    sailThreeHeight = 260
                } else if sailThreeHeight < 0 {
                    sailThreeHeight = 0
                    for player in gameService.party.players {
                        if player.role == Role.sailingMaster {
                            if player.event.objective == Objective.slow30 {
                                isSlowProgressCompleted = Objective.slow30
                                break
                            }
                        }
                    }
                } else {
                    totalAngleThree = newAngle
                }
            }
            
        default:
            print("oke")
        }
    }
    
    var body: some View {
        if roleExplain == false {
            GeometryReader{proxy in
                let size = proxy.size
                ZStack {
                    Image("sailingmasterExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
                        timeExplain -= 0.1
                        if timeExplain <= 1.1 {
                            timeExplain = 0
                            roleExplain = true
                        }
                    }
                    Text("Sailing In... \(String(String(timeExplain).first!))")
                        .font(.custom("Gasoek One", size: 20))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                        .position(x: size.width / 2, y: 215)
                        .multilineTextAlignment(.center)
                      
                }
            }.ignoresSafeArea()
        } else {
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
                                if eventblacksmith == false {
                                    Text("\(player.event.instruction)")
                                        .font(Font.custom("Gasoek One", size: 20))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 20)
                                        .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                                        .background(
                                            Rectangle()
                                                .opacity(0.5))
                                } else {
                                    Text("Your sail is broken")
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
                                if eventblacksmith == false{
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
                                else{
                                    Image("Tuas1")
                                        .resizable()
                                        .frame(width: 24, height: 63)
                                        .padding(.bottom, 50)
                                }
                                
                            }
                            Spacer()
                                .frame(height: 80)
                            ZStack{
                                Image("Tuas2")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                if eventblacksmith == false{
                                    Image("Tuas1")
                                        .resizable()
                                        .frame(width: 24, height: 63)
                                        .padding(.bottom, 50).valueRotation(
                                            totalAngle: $totalAngleTwo,
                                            onAngleChanged: { newAngle in
                                                changeHeight(sail: 2, newAngle: newAngle)
                                            }
                                        )
                                }else{
                                    Image("Tuas1")
                                        .resizable()
                                        .frame(width: 24, height: 63)
                                        .padding(.bottom, 50)
                                }
                                
                            }
                            Spacer()
                                .frame(height: 120)
                            ZStack{
                                Image("Tuas2")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                if eventblacksmith == false{
                                    Image("Tuas1")
                                        .resizable()
                                        .frame(width: 24, height: 63)
                                        .padding(.bottom, 50).valueRotation(
                                            totalAngle: $totalAngleThree,
                                            onAngleChanged: { newAngle in
                                                changeHeight(sail: 3, newAngle: newAngle)
                                            }
                                        )
                                }else{
                                    Image("Tuas1")
                                        .resizable()
                                        .frame(width: 24, height: 63)
                                        .padding(.bottom, 50)
                                }
                                
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
                
                RecapSceneView(lives: $lives, show: $showPopUp, isStartGame: $isStartGame)
            }
            .overlay(content: {
                if showSuccessOverlay {
                    VStack {
                        Text("SAFE!")
                            .font(.custom("Gasoek One", size: 40))
                    }
                    .onAppear {
                        withAnimation(.easeOut(duration: 1)) {
                            showSuccessOverlay = false
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.green)
                }
                
                if gameService.party.flashred {
                    VStack {
                        Text("OUCH!")
                            .font(.custom("Gasoek One", size: 40))
                    }
                    .onAppear {
                        withAnimation(.easeOut(duration: 1)) {
                            gameService.party.flashred = false
                            gameService.send(party: gameService.party)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.red)
                }
            })
            .onAppear {
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.sailingMaster {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
                    
                    if player.role == Role.blackSmith {
                        let obj = gameService.party.players[index].event.objective
                        if obj == Objective.sail{
                            eventblacksmith = true
                        } else {
                            eventblacksmith = false
                        }
                    }
                }
            }
            .onChange(of: gameService.party, perform: { newValue in
                if gameService.party.lives == 0 {
                    withAnimation(.linear(duration: 0.5)) {
                        lives = gameService.party.lives
                        showPopUp = true
                        
                    }
                    //                            gameService.parties[index].reset()
                    //                            isStartGame = false
                    //                            gameService.send(parties: gameService.parties)
                }
                if gameService.party.popup == true{
                    withAnimation(.linear(duration: 0.5)) {
                        lives = gameService.party.lives
                        showPopUp = true
                    }
                }
                var allEventsCompleted = true
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.blackSmith {
                        if gameService.party.players[index].event.isCompleted == true {
                            eventblacksmith = false
                        }
                    }
                    
                    if !player.event.isCompleted {
                        allEventsCompleted = false
                    }
                }
                
                if allEventsCompleted {
                    showSuccessOverlay = true
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
                        }
                        
                        if player.role == Role.blackSmith {
                            let obj = gameService.party.players[index].event.objective
                            if obj == Objective.sail{
                                eventblacksmith = true
                            } else {
                                eventblacksmith = false
                            }
                        }
                    }
                    withAnimation(Animation.spring()) {
                        totalAngleOne = 0.0
                        totalAngleTwo = 0.0
                        totalAngleThree = 0.0
                        sailOneHeight = 112
                        sailTwoHeight = 160
                        sailThreeHeight = 260
                        isSlowProgressCompleted = nil
                    }
                }
            })
            
            .onChange(of: instructionProgress, perform: { newValue in
                if instructionProgress <= 0 {
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            withAnimation(Animation.spring()) {
                                totalAngleOne = 0.0
                                totalAngleTwo = 0.0
                                totalAngleThree = 0.0
                                sailOneHeight = 112
                                sailTwoHeight = 160
                                sailThreeHeight = 260
                                isSlowProgressCompleted = nil
                            }
                            instructionProgress = gameService.party.players[index].event.duration
                        }
                    }
                }
            })
            .onChange(of: isSlowProgressCompleted) { newValue in
                if isSlowProgressCompleted != nil {
                    for (_, player) in gameService.party.players.enumerated() {
                        if player.role == Role.sailingMaster {
                            if isSlowProgressCompleted == player.event.objective {
                                gameService.party.setEventCompleted(role: Role.sailingMaster)
                                gameService.send(party: gameService.party)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SailingMasterView_Previews: PreviewProvider {
    static var previews: some View {
        SailingMasterView(isStartGame: .constant(false)).environmentObject(GameService())
    }
}
