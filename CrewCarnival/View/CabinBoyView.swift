//
//  CabinBoyView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 27/06/23.
//

import SwiftUI

struct CabinBoyView: View {
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var roleExplain = false
    @State var timeExplain = 7.9
    @State private var showPopUp: Bool = false
    @State private var isHelemsmanDeactive: Bool = true
    @State private var isSailingMasterDeactive: Bool = true
    @State private var isLookoutDeactive: Bool = true
    @State private var lives = 0
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
    @State private var choose = "helmsman"
    @State private var available = "sailingmaster"
    @State var showingPopup = false
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    
    @State private var yOffsetChar: CGFloat = 0
    
    @State var timerSideEvent = Timer.publish(every: 1, on: .main, in: .default)
    @State private var counter = 0
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .default)
    var body: some View {
        if roleExplain == false{
            GeometryReader{proxy in
                let size = proxy.size
                
                ZStack {
                    Image("cabinboyExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
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
                    
                }.onAppear{
                    _ = timer.connect()
                }
            }.ignoresSafeArea()
        }else{
            let gradientStyle = GradientProgressStyle(
                stroke: .clear,
                fill: gradient,
                caption: ""
            )
            ZStack{
                Image("CabinBoyBack").resizable().scaledToFill().ignoresSafeArea(.all).offset(x:xOffset)
                Button{
                    showingPopup = true
                    choose = "helmsman"
                    gameService.party.chose = true
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 174, height: 257)
                        .background(
                            VStack{
                                Text("Helmsman")
                                    .font(.custom("Gasoek One", size: 20))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                                    .offset(y:yOffsetChar)
                                Image("CharHelmsman")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 174, height: 237)
                                    .clipped()
                            }
                        )
                }.offset(x:-50,y:-90).disabled(showingPopup || isHelemsmanDeactive)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 335, height: 262)
                    .background(
                        Image("CabinBoyStair")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 335, height: 262)
                            .clipped()
                    ).offset(y:92)
                Button{
                    showingPopup = true
                    choose = "sailingmaster"
                    gameService.party.chose = true
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 170, height: 247)
                        .background(
                            VStack{
                                Text("Sailing Master")
                                    .font(.custom("Gasoek One", size: 20))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                                    .offset(y:yOffsetChar)
                                Image("CharSailingMaster")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 110, height: 247)
                                    .clipped()
                            }
                        )
                }.offset(x:-100,y:160).disabled(showingPopup || isSailingMasterDeactive)
                Button{
                    showingPopup = true
                    choose = "lookout"
                    gameService.party.chose = true
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 121, height: 216)
                        .background(
                            VStack{
                                Text("Lookout")
                                    .font(.custom("Gasoek One", size: 20))
                                    .foregroundColor(.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                                    .offset(y:yOffsetChar)
                                Image("CharLookout")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 121, height: 216)
                                    .clipped()
                            }
                        )
                }.offset(x:110,y:200).disabled(showingPopup || isLookoutDeactive)
                if showingPopup {
                    popUpView
                }
                VStack{
                    HStack{
                        Text("Cabin Boy")
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
                    Spacer()
                    Spacer()
                }
                .padding(.vertical,50)
                RecapSceneView(lives: $lives, show: $showPopUp, isStartGame: $isStartGame)
            }
            .onAppear {
                _ = timerSideEvent.connect()
                withAnimation (Animation.easeInOut (duration: 1).repeatForever()){
                    yOffsetChar += 12
                }
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.cabinBoy {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                        for (index2, player2) in gameService.party.players.enumerated() {
                            if player2.role == Role.blackSmith {
                                let obj = gameService.party.players[index2].event.objective
                                if obj == Objective.sail {
                                    gameService.party.players[index].event.instruction = "Talk to Sailing Master"
                                    available = "sailingmaster"
                                } else if obj == Objective.steer {
                                    gameService.party.players[index].event.instruction = "Talk to Helmsman"
                                    available = "helmsman"
                                } else {
                                    gameService.party.players[index].event.instruction = "Talk to Lookout"
                                    available = "lookout"
                                }
                            }
                        }
                    }
                }
                gameService.send(party: gameService.party)
                if available == "sailingmaster" {
                    isSailingMasterDeactive = false
                } else if available == "helmsman" {
                    isHelemsmanDeactive = false
                } else if available == "lookout" {
                    isLookoutDeactive = false
                }
            }
            .onReceive(timerSideEvent){ time in
                //                print("Pos dede")
                var allEventsCompleted = true
                for (_, player) in gameService.party.players.enumerated() {
                    if !player.event.isCompleted {
                        allEventsCompleted = false
                    }
                }
                if !allEventsCompleted && !gameService.party.isSideEvent {
                    if counter == 5 {
                        gameService.party.generateSideEvent()
//                        for (index, player) in gameService.party.players.enumerated() {
//                            if player.role == Role.cabinBoy {
//                                instructionProgress = gameService.party.players[index].event.duration
//                                instructionProgressMax = gameService.party.players[index].event.duration
//                            }
//                        }
                        gameService.party.isSideEvent = true
                        gameService.send(party: gameService.party)
                        counter = 0
                        //                        print("")
                    }
                    print("masuk disini")
                    counter += 1
                }
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
                
                var allEventsCompleted = true
                for (_, player) in gameService.party.players.enumerated() {
                    if !player.event.isCompleted {
                        allEventsCompleted = false
                    }
                }
                
                if allEventsCompleted {
                    gameService.party.generateLHSEvent()
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.cabinBoy {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
//                            for (index2, player2) in gameService.party.players.enumerated() {
//                                if player2.role == Role.blackSmith {
//                                    let obj = gameService.party.players[index2].event.objective
//                                    if obj == Objective.sail {
//                                        gameService.party.players[index].event.instruction = "Talk to Sailing Master"
//                                    } else if obj == Objective.steer {
//                                        gameService.party.players[index].event.instruction = "Talk to Helmsman"
//                                    } else {
//                                        gameService.party.players[index].event.instruction = "Talk to Lookout"
//                                    }
//                                }
//                            }
                        }
                    }
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
                        if player.role == Role.cabinBoy {
                            instructionProgress = gameService.party.players[index].event.duration
                        }
                    }
                }
            })
        }
        
    }
    
    var popUpView: some View {
        ZStack{
            Rectangle().opacity(0.5).ignoresSafeArea()
            switch choose {
            case "sailingmaster":
                Button{
                    gameService.party.chose = true
                    gameService.send(party: gameService.party)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 106, height: 106)
                            .background(
                                Image("Sail")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 106, height: 106)
                                    .clipped()
                            )
                    }
                }.offset(x:-100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:-100,y:200)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100,y:200)
                
            case "helmsman":
                Button{
                    gameService.party.chose = true
                    gameService.send(party: gameService.party)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 106, height: 106)
                            .background(
                                Image("StearingWheel")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 106, height: 106)
                                    .clipped()
                            )
                    }
                }.offset(x:-100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:-100,y:200)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100,y:200)
                
            case "blacksmith":
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:-100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:-100,y:200)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100,y:200)
                
            case "lookout":
                Button{
                    gameService.party.chose = true
                    gameService.send(party: gameService.party)
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 106, height: 106)
                            .background(
                                Image("binocular")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 106, height: 106)
                                    .clipped()
                            )
                    }
                }.offset(x:-100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:-100,y:200)
                Button{
                    
                } label: {
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 165, height: 171)
                            .background(
                                Image("Box")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 165, height: 171)
                                    .clipped()
                            )
                    }
                }.offset(x:100,y:200)
                
            default:
                Rectangle().opacity(0.5).ignoresSafeArea()
            }
            Button{
                showingPopup = false
            } label: {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 45, height: 42)
                    .background(
                        Image("CloseButton")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 45, height: 42)
                            .clipped()
                    )
            }.offset(x:90,y:-150)
        }
    }
}

struct CabinBoyView_Previews: PreviewProvider {
    static var previews: some View {
        CabinBoyView(isStartGame: .constant(false)).environmentObject(GameService())
    }
}
