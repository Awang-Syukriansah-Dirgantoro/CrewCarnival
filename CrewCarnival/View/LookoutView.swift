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
    @State private var roleExplain = false
    @State var timeExplain = 7.9
    @State private var showPopUp: Bool = false
    @State private var lives = 0
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @State private var xOffset:CGFloat = -1
    @State private var xOffsettengah:CGFloat = 0
    @State private var isMove = false
    @State private var direction = "Forward"
    @State  var looks:String = ""
    @State private var isLeftAble = true
    @State private var isRightAble = true
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    @State var eventblacksmith = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var ganti = 1
    var body: some View {
        if roleExplain == false{
            GeometryReader{proxy in
                let size = proxy.size
                ZStack {
                    Image("lookoutExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
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
            ZStack{
                GeometryReader {proxy in
                    let size = proxy.size
                   
                    PlayerView(look: $looks).frame(width: size.width * 3, height: size.height).offset(x: xOffset).onAppear{
                        xOffset = -size.width
                        xOffsettengah = -size.width
                    }
                
                VStack{
                    HStack{
                        Text("Lookout")
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
                        .padding(.top, 50)
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
                                if partyProgress < 100 && showPopUp == false{
                                    partyProgress += 0.1
                                    gameService.party.partyProg = partyProgress

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
                                    Text("Your binocular is broken")
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
                        Text("You Are Facing \(direction)")
                            .font(Font.custom("Krub-Regular", size: 18))
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
                                xOffset += size.width
                            }
                            if xOffset == -size.width {
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
                        }.disabled(!isLeftAble).disabled(eventblacksmith)
                        Spacer()
                        Button{
                            isMove = true
                            isLeftAble = false
                            isRightAble = false
                            withAnimation (Animation.easeOut (duration: 3)){
                                xOffset -= size.width
                            }
                            if xOffset == -size.width {
                                direction = "Forward"
                                isLeftAble = true
                                isRightAble = true
                            } else {
                                direction = "Right"
                                isLeftAble = true
                                isRightAble = false
                            }
//                            ganti = ganti + 1
//                            if ganti > 3{
//                                ganti = 1
//                            }
//                            looks = "Lookout\(ganti)"
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
                        }.disabled(!isRightAble).disabled(eventblacksmith)
                        Spacer()
                    }.padding(.bottom, 50)
                }
                }
                .ignoresSafeArea()
                
                if gameService.party.flashred{
                    Color.red.edgesIgnoringSafeArea(.all).opacity(gameService.party.flashred ? 0.8 : 0.0).onAppear{
                        withAnimation(Animation.spring().speed(0.2)){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                gameService.party.flashred = false
                                gameService.send(party: gameService.party)
                            }
                        }
                    }
                }
                RecapSceneView(lives: $lives, show: $showPopUp, isStartGame: $isStartGame)
            }
            
            .task{
//                self.views = listView.randomElement()!
//                print("videoNamelook: \(self.views)")
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.lookout {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
                }
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.blackSmith {
                        let obj = gameService.party.players[index].event.objective
                        if obj == Objective.binocular{
                            eventblacksmith = true
                        } else {
                            eventblacksmith = false
                        }
                    }
                }
//                print(looks)
                for (_, player) in gameService.party.players.enumerated() {
                    if player.role == Role.lookout {
                        if player.event.objective == Objective.lookLeft {
                            looks = "LookoutLeft"
                        } else {
                            looks = "LookoutRight"
                        }
                    }
                }
//                looks = "Lookout3"
//                print("Luar",looks)
            }
            .onChange(of: gameService.party, perform: { newValue in
                if gameService.party.lives == 0 {
                    gameService.send(party: gameService.party)
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
                    gameService.party.generateLHSEvent()
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.lookout {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
                            if player.event.objective == Objective.lookLeft {
                                looks = "LookoutLeft"
                            } else {
                                looks = "LookoutRight"
                            }
                        }
                        
                        if player.role == Role.blackSmith {
                            let obj = gameService.party.players[index].event.objective
                            if obj == Objective.binocular{
                                eventblacksmith = true
                            } else {
                                eventblacksmith = false
                            }
                        }
                    }

                    withAnimation(Animation.spring()) {
                        isMove = false
                        direction = "Forward"
                        isLeftAble = true
                        isRightAble = true
                        xOffset = xOffsettengah
                    }
                    gameService.send(party: gameService.party)
                }
            })
            .onChange(of: partyProgress, perform: { newValue in
                if partyProgress >= 100{
                    gameService.send(party: gameService.party)
                    withAnimation(.linear(duration: 0.5)) {
                        lives = gameService.party.lives
                        showPopUp = true
                    }
                }
            })
            .onChange(of: instructionProgress, perform: { newValue in
                if instructionProgress <= 0 {
                    gameService.party.generateLHSEvent()
                    if gameService.party.lives > 0 {
                        withAnimation(Animation.spring()) {
                            gameService.party.lives -= 1
                            gameService.party.flashred = true
                            isMove = false
                            direction = "Forward"
                            isLeftAble = true
                            isRightAble = true
                            xOffset = xOffsettengah
                        }
                    }
                    gameService.send(party: gameService.party)
                    
                    
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.lookout {
                            if player.event.objective == Objective.lookLeft {
                                looks = "LookoutLeft"
                            } else {
                                looks = "LookoutRight"
                            }
                            instructionProgress = gameService.party.players[index].event.duration
                        }
                    }
                }
            })
            .onChange(of: direction) { newDirection in
                print("dir \(direction)")
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.lookout {
                        if player.event.objective == Objective.lookLeft {
                            if newDirection == "Left" {
                                withAnimation(Animation.spring().delay(3)) {
                                    gameService.party.players[index].event.instruction = "Our Left is Clear!\nQuickly Turn the Ship!"
                                    gameService.party.setEventCompleted(role: Role.lookout)
                                    gameService.send(party: gameService.party)
                                }
                            }
                        } else {
                            if newDirection == "Right" {
                                withAnimation(Animation.spring().delay(3)) {
                                    gameService.party.players[index].event.instruction = "Our Right is Clear!\nQuickly Turn the Ship!"
                                    gameService.party.setEventCompleted(role: Role.lookout)
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

struct LookoutView_Previews: PreviewProvider {
    static var previews: some View {
        LookoutView(isStartGame: .constant(false))
            .environmentObject(GameService())
    }
}
