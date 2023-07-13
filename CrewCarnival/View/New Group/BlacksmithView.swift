//
//  BlacksmithView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 24/06/23.
//

import SwiftUI

struct BlacksmithView: View {
    @StateObject var vm = PuzzleViewModel()
    @State private var partyProgress = 0.0
    @State private var instructionProgress = 100.0
    @State private var instructionProgressMax = 100.0
    @State private var roleExplain = false
    @State var timeExplain = 7.9
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var showPopUp: Bool = false
    @State private var lives = 0
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    @State private var isPuzzleCompleted = false
    @State var objct: Objective?
    @State var showSuccessOverlay = false
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var body: some View {
        if roleExplain == false{
            GeometryReader{proxy in
                let size = proxy.size
                
                ZStack {
                    Image("blacksmithExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
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
                
                Image("BgBlacksmith")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                VStack{
                    HStack{
                        Text("Blacksmith")
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
                        .padding(.top, 30)
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
                    ZStack {
                        if gameService.party.chose {
                            Drop(vm: vm, isPuzzleCompleted: $isPuzzleCompleted)
                                .padding(.vertical,30)
                            Drag(vm: vm).offset(y: 300)
                        }
                    }
                    .padding()
                    .offset(x: vm.animateWrong ? -30 : 0)
                    .environmentObject(vm)
                    Spacer()
                }
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
                    if player.role == Role.blackSmith {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
                    
                    if player.role == Role.blackSmith {
                        objct = gameService.party.players[index].event.objective
                    }
                }
                vm.shuffleArray(objct: objct)
                isPuzzleCompleted = false
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
                for (_, player) in gameService.party.players.enumerated() {
                    if !player.event.isCompleted {
                        allEventsCompleted = false
                    }
                }
                
                if allEventsCompleted {
                    showSuccessOverlay = true
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.blackSmith {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
                        }
                    }
//                    vm.shuffleEvent()
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.cabinBoy {
                            objct = gameService.party.players[index].event.objective
                        }
                    }
                    vm.shuffleArray(objct: objct)
                    isPuzzleCompleted = false
                }
            })
            .onChange(of: instructionProgress, perform: { newValue in
                if instructionProgress <= 0 {
                    for (index, player) in gameService.party.players.enumerated() {
                        if player.role == Role.blackSmith {
                            instructionProgress = gameService.party.players[index].event.duration
                        }
                    }
                }
            })
            .onChange(of: isPuzzleCompleted) { newValue in
                if isPuzzleCompleted == true {
                    gameService.party.setEventCompleted(role: Role.blackSmith)
                    gameService.party.setEventCompleted(role: Role.cabinBoy)
                    gameService.party.isSideEvent = false
//                    isPuzzleCompleted = false
//
//                    gameService.party.generateLHSEvent()
//                    for (index, player) in gameService.party.players.enumerated() {
//                        if player.role == Role.blackSmith {
//                            objct = gameService.party.players[index].event.objective
//                        }
//                    }
//                    vm.shuffleArray(objct: objct)
                    gameService.send(party: gameService.party)
                }
            }
            
        }
    }
    

}

struct BlacksmithView_Previews: PreviewProvider {
    static var previews: some View {
        BlacksmithView(isStartGame: .constant(false)).environmentObject(GameService())
    }
}
