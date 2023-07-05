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
    @State private var isTurnProgressCompleted: Objective?
    @State private var roleExplain = false
    @State var timeExplain = 100
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
    @Binding var isStartGame: Bool
    @State private var text = "Turn Progress"
    
    var body: some View {
        if roleExplain == false{
            Image("helmsmanExplain").edgesIgnoringSafeArea(.all).onReceive(timer) { _ in
                timeExplain -= 1
                if timeExplain == 0 {
                    roleExplain = true
                }
            }
        }else{
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
                                        isTurnProgressCompleted = Objective.turnRight
                                    } else if (self.angle < 0){
                                        if (self.angle < -300){
                                            self.angle = -300
                                            self.progress = 300
                                            isTurnProgressCompleted = Objective.turnLeft
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
                            Text(text)
                                .foregroundColor(.white)
                                .onShake {
                                    text = "shaken at \(Date())"
                                }
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
                                if player.role == Role.helmsman {
                                    instructionProgress = gameService.parties[index].players[index2].event.duration
                                    instructionProgressMax = gameService.parties[index].players[index2].event.duration
                                }
                            }
                            progress = 0
                            angle = 0
                            lastAngle = 0
                            isTurnProgressCompleted = nil
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
            .onChange(of: isTurnProgressCompleted) { newValue in
                print(progress)
                if (isTurnProgressCompleted != nil) {
                    for (index, party) in gameService.parties.enumerated() {
                        if party.id == partyId {
                            for (index2, player) in gameService.parties[index].players.enumerated() {
                                if player.role == Role.helmsman {
                                    if player.event.objective == Objective.turnLeft {
                                        if isTurnProgressCompleted == Objective.turnLeft {
                                            for (_, player2) in gameService.parties[index].players.enumerated() {
                                                if player2.role == Role.sailingMaster {
                                                    if player2.event.objective == Objective.slow10 {
                                                        gameService.parties[index].players[index2].event.instruction = "The Ship is Tilting,\nSlow Down 10 Knots!"
                                                    } else if player2.event.objective == Objective.slow20 {
                                                        gameService.parties[index].players[index2].event.instruction = "The Ship is Tilting,\nSlow Down 20 Knots!"
                                                    } else {
                                                        gameService.parties[index].players[index2].event.instruction = "The Ship is Tilting,\nSlow Down 30 Knots!"
                                                    }
                                                }
                                            }
    //                                        gameService.parties[index].triggerSailingMasterInstruction()
                                        }
                                    } else {
                                        if isTurnProgressCompleted == Objective.turnRight {
                                            gameService.parties[index].players[index2].event.instruction = "The Ship is Tilting,\nSlow Down 10 Knots!"
    //                                        gameService.parties[index].triggerSailingMasterInstruction()
                                        }
                                    }
                                    gameService.parties[index].setEventCompleted(role: Role.lookout)
                                    gameService.send(parties: gameService.parties)
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct HelmsmanView_Previews: PreviewProvider {
    static var previews: some View {
        HelmsmanView(partyId: UUID(), isStartGame: .constant(false)).environmentObject(GameService())
    }
}
