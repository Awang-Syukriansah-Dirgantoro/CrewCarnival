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
    @State private var lockSteer = false
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
    
    @State var numStory: Int = 0
    @State var timeStory = 5.9
    @State var timeStory2 = 5.9
    @State var timeStory3 = 5.9
    @State var timeStory4 = 5.9
    @State var timeStory5 = 5.9
    @State var timeStory6 = 5.9
    @State var looks:String = "scene1"
    @State var looks2:String = "scene2"
    @State var looks4:String = "scene4"
    @State var looks5:String = "scene2"
    @State var looks6:String = "scene1"
    
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
                            numStory = 1
                        }
                    }
                }
            }.ignoresSafeArea()
        }else{
            if numStory == 1 {
                GeometryReader{proxy in
                    PlayerView(look: $looks).ignoresSafeArea().onReceive(timer) { _ in
                        timeStory -= 0.1
                        if timeStory <= 1.1 {
                            timeStory = 0
                            numStory = 2
                        }
                    }
                }
            } else if numStory == 2 {
                GeometryReader{proxy in
                    PlayerView(look: $looks2).ignoresSafeArea().onReceive(timer) { _ in
                        timeStory2 -= 0.1
                        if timeStory2 <= 1.1 {
                            timeStory2 = 0
                            numStory = 3
                        }
                    }
                }
            } else if numStory == 3 {
                GeometryReader{proxy in
                    Image("Scene3").resizable()
                        .scaledToFill().onReceive(timer) { _ in
                        timeStory3 -= 0.1
                        if timeStory3 <= 1.1 {
                            timeStory3 = 0
                            numStory = 4
                        }
                    }
                }
                .ignoresSafeArea()
            } else if numStory == 4 {
                GeometryReader{proxy in
                    PlayerView(look: $looks4).ignoresSafeArea().onReceive(timer) { _ in
                        timeStory4 -= 0.1
                        if timeStory4 <= 1.1 {
                            timeStory4 = 0
                            numStory = 5
                        }
                    }
                }
            } else if numStory == 5 {
                GeometryReader{proxy in
                    Image("Scene3").resizable()
                        .scaledToFill().onReceive(timer) { _ in
                        timeStory5 -= 0.1
                        if timeStory5 <= 1.1 {
                            timeStory5 = 0
                            numStory = 6
                        }
                    }
                }
                .ignoresSafeArea()
            } else if numStory == 6 {
                GeometryReader{proxy in
                    let size = proxy.size
                    PlayerView(look: $looks2).ignoresSafeArea().onReceive(timer) { _ in
                        timeStory6 -= 0.1
                        if timeStory6 <= 1.1 {
                            timeStory6 = 0
                            numStory = 7
                        }
                    }
                    Text("Sailing In... \(String(String(timeStory6).first!))")
                        .font(.custom("Gasoek One", size: 20))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                        .position(x: size.width / 2, y: 215)
                        .multilineTextAlignment(.center)
                }
                
            }
            else {
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
                                        if player.role == Role.helmsman {
//                                            if player.event.objective == Objective.turnLeft {
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
//                                                    .onAppear{
//                                                        knobValue = 1
//                                                    }
                                                    .onChange(of: knobValue, perform: { newValue in
                                                        var value = "\(knobValue)"
                                                        
                                                        if player.event.objective == Objective.turnLeft {
                                                            if Double(value)! <= 0.5 {
                                                                self.progress = (1 - Double(value)! - 0.5) * 200
                                                                
                                                                if self.progress >= 100 {
                                                                    isTurnProgressCompleted = Objective.turnLeft
                                                                    lockSteer = true
                                                                }
                                                            }
                                                        } else {
                                                            if Double(value)! >= 0.5 {
                                                                self.progress = (Double(value)! - 0.5) * 200
                                                                if self.progress >= 100 {
                                                                    isTurnProgressCompleted = Objective.turnRight
                                                                    lockSteer = true
                                                                }
                                                            }
                                                        }
                                                        //                                                var value = "\(knobValue)"
                                                        //                                                if Double(value)! > 0.5 {
                                                        //                                                    self.progress = (Double(value)! - 0.5) * 200
                                                        //                                                } else {
                                                        //                                                    self.progress = ((1 - Double(value)!) - 0.5) * 200
                                                        //                                                }
                                                    })
//                                            }
//                                            else {
//                                                Image("StearingWheel")
//                                                    .resizable()
//                                                    .scaledToFill()
//                                                    .frame(width: 300, height: 300)
//                                                    .knobRotation(
//                                                        knobValue: $knobValue,
//                                                        minAngle: -360,
//                                                        maxAngle: +360,
//                                                        onKnobValueChanged: { newValue in
//                                                            knobValue = newValue
//                                                            lockSteer = true
//                                                        },
//                                                        animation: .spring()
//                                                    )
//                                                    .onAppear{
//                                                        knobValue = 0
//                                                    }
//                                                    .onChange(of: knobValue, perform: { newValue in
//                                                        var value = "\(knobValue)"
//                                                        self.progress = Double(value)! * 100
//                                                        if self.progress >= 100 {
//                                                            isTurnProgressCompleted = Objective.turnRight
//                                                            lockSteer = true
//                                                        }
//                                                    })
//                                            }
                                        }
                                    }
                                } else {
                                    Image("StearingWheel")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height: 300)
                                }
                            }else{
                                Image("StearingWheel")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 300)
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
                    lockSteer = false
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
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.helmsman {
                            instructionProgress = gameService.party.players[index].event.duration
                        }
                        //                            gameService.parties[index].reset()
                        //                            isStartGame = false
                        //                            gameService.send(parties: gameService.parties)
                    }
                    lockSteer = false
                    progress = 0
                    angle = 0
                    lastAngle = 0
                    isTurnProgressCompleted = nil
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
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            } else if player2.event.objective == Objective.slow20 {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 20 Knots!"
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            } else {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 30 Knots!"
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            }
                                        }
                                    }
                                }
                            } else {
                                if isTurnProgressCompleted == Objective.turnRight {
                                    for (_, player2) in gameService.party.players.enumerated() {
                                        if player2.role == Role.sailingMaster {
                                            if player2.event.objective == Objective.slow10 {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 10 Knots!"
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            } else if player2.event.objective == Objective.slow20 {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 20 Knots!"
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            } else {
                                                gameService.party.players[index].event.instruction = "The Ship is Tilting,\nSlow Down 30 Knots!"
                                                gameService.party.setEventCompleted(role: Role.helmsman)
                                                gameService.send(party: gameService.party)
                                            }
                                        }
                                    }
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
        HelmsmanView(isStartGame: .constant(false))
            .environmentObject(GameService())
    }
}
