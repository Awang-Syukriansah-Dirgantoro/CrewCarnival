//
//  HelmsmanView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 21/06/23.
//

import SwiftUI
import OneFingerRotation

struct HelmsmanView: View {
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var isTurnProgressCompleted: Objective?
    @State private var roleExplain = false
    @State var timeExplain = 7.9
    @State private var showPopUp: Bool = false
    @State private var lives = 0
    @EnvironmentObject var gameService: GameService
    
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
    
    @State private var knobValue: Double = 0.5
    @State var eventblacksmith = false
    
    var body: some View {
        if roleExplain == false{
            GeometryReader{proxy in
                let size = proxy.size
                ZStack {
                    Image("helmsmanExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
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
                                        Text("Your steer is broken")
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
                        if eventblacksmith == false{
                            Image("StearingWheel")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .knobRotation(
                                  knobValue: $knobValue,
                                  minAngle: -360,
                                  maxAngle: +360,
                                  onKnobValueChanged: { newValue in
                                    knobValue = newValue
                                  },
                                  animation: .spring()
                                )
                                .onChange(of: knobValue, perform: { newValue in
                                    var value = "\(knobValue)"
                                    if Double(value)! > 0.5 {
                                        self.progress = (Double(value)! - 0.5) * 200
                                    } else {
                                        self.progress = ((1 - Double(value)!) - 0.5) * 200
                                    }
                                }).offset(y: 150)
                        }else{
                            Image("StearingWheel")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300).offset(y: 150)
                        }
                        
//                            .rotationEffect(
//                                .degrees(Double(self.angle)))
//                            .gesture(DragGesture()
//                                .onChanged{ v in
//                                    let theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
//                                    self.angle = theta + self.lastAngle
//                                    print(self.angle)
//
//                                    if (self.angle > 300){
//                                        self.angle = 300
//                                        self.progress = self.angle
//                                        isTurnProgressCompleted = Objective.turnRight
//                                    } else if (self.angle < 0){
//                                        if (self.angle < -300){
//                                            self.angle = -300
//                                            self.progress = 300
//                                            isTurnProgressCompleted = Objective.turnLeft
//                                        } else {
//                                            self.progress = self.angle * (-1)
//                                        }
//                                    }
//                                    else {
//                                        self.progress = self.angle
//                                    }
//                                    print(self.angle)
//                                }
//                                .onEnded { v in
//                                    self.lastAngle = self.angle
//                                }
//                            )
                            
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
                    
                    RecapSceneView(lives: $lives, show: $showPopUp, isStartGame: $isStartGame)
                }.background(Image("BgHelmsman").resizable().scaledToFit())
            }
            .onAppear {
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.helmsman {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
                }
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.blackSmith {
                        let obj = gameService.party.players[index].event.objective
                        if obj == Objective.steer{
                            eventblacksmith = true
                        } else {
                            eventblacksmith = false
                        }
                    }
                }
                progress = 0
                angle = 0
                lastAngle = 0
                isTurnProgressCompleted = nil
                gameService.send(party: gameService.party)
            }
            .onChange(of: gameService.party, perform: { newValue in
                if gameService.party.lives <= 0 {
                    withAnimation(.linear(duration: 0.5)) {
                        lives = gameService.party.lives
                        showPopUp = true
                        
                    }
                    //                            gameService.parties[index].reset()
                    //                            isStartGame = false
                    //                            gameService.send(parties: gameService.parties)
                }
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.blackSmith {
                        if gameService.party.players[index].event.isCompleted == true {
                            eventblacksmith = false
                        }
                    }
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
                        if player.role == Role.helmsman {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
                        }
                    }
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.blackSmith {
                            let obj = gameService.party.players[index].event.objective
                            if obj == Objective.steer{
                                eventblacksmith = true
                            } else {
                                eventblacksmith = false
                            }
                        }
                    }
                    progress = 0
                    angle = 0
                    lastAngle = 0
                    isTurnProgressCompleted = nil
                    gameService.send(party: gameService.party)
                }
            })
            .onChange(of: partyProgress, perform: { newValue in
                if partyProgress >= 100{
                    withAnimation(.linear(duration: 0.5)) {
                        lives = gameService.party.lives
                        showPopUp = true
                    }
                }
            })
            .onChange(of: instructionProgress, perform: { newValue in
                if instructionProgress <= 0 {
                    for (index, _) in gameService.party.players.enumerated() {
                        instructionProgress = gameService.party.players[index].event.duration
                    }
                }
            })
            .onChange(of: isTurnProgressCompleted) { newValue in
                print(progress)
                if (isTurnProgressCompleted != nil) {
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.helmsman {
                            if player.event.objective == Objective.turnLeft {
                                if isTurnProgressCompleted == Objective.turnLeft {
                                    for (_, player2) in gameService.party.players.enumerated() {
                                        if player2.role == Role.sailingMaster {
                                            if player2.event.objective == Objective.slow10 {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 10 Knots!"
                                            } else if player2.event.objective == Objective.slow20 {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 20 Knots!"
                                            } else {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 30 Knots!"
                                            }
                                        }
                                    }
                                    //                                        gameService.parties[index].triggerSailingMasterInstruction()
                                }
                            } else {
                                if isTurnProgressCompleted == Objective.turnRight {
                                    gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 10 Knots!"
                                    //                                        gameService.parties[index].triggerSailingMasterInstruction()
                                }
                            }
                            gameService.party.setEventCompleted(role: Role.lookout)
                            gameService.send(party: gameService.party)
                        }
                    }
                }
            }
        }
        
    }
}

struct HelmsmanView_Previews: PreviewProvider {
    static var previews: some View {
        HelmsmanView(isStartGame: .constant(false))
            .environmentObject(GameService())
    }
}
