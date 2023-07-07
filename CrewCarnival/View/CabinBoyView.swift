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
    @State var timeExplain = 70
    @State private var showPopUp: Bool = false
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
    @State var showingPopup = false
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    var partyId: UUID
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        if roleExplain == false{
            GeometryReader{proxy in
                let size = proxy.size
                
                Image("cabinboyExplain").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).onReceive(timer) { _ in
                    timeExplain -= 1
                    if timeExplain == 0 {
                        roleExplain = true
                    }
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
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 174, height: 237)
                        .background(
                            Image("CharHelmsman")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 174, height: 237)
                                .clipped()
                        )
                }.offset(x:-50,y:-60).disabled(showingPopup)
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
                    choose = "blacksmith"
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 101, height: 252)
                        .background(
                            Image("CharBlacksmith")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 101, height: 252)
                                .clipped()
                        )
                }.offset(y:140).disabled(showingPopup)
                Button{
                    showingPopup = true
                    choose = "sailingmaster"
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 110, height: 247)
                        .background(
                            Image("CharSailingMaster")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 110, height: 247)
                                .clipped()
                        )
                }.offset(x:-130,y:190).disabled(showingPopup)
                Button{
                    showingPopup = true
                    choose = "lookout"
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 121, height: 216)
                        .background(
                            Image("CharLookout")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 121, height: 216)
                                .clipped()
                        )
                }.offset(x:130,y:240).disabled(showingPopup)
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
                                    partyProgress += 2
                                }
                            }
                    }.padding(.bottom,20).padding(.horizontal,30)
                    ZStack{
                        Rectangle().frame(height: 60).opacity(0.5)
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if gameService.currentPlayer.id == player.id {
                                Text("\(gameService.party.players[index].event.instruction)")
                                    .font(Font.custom("Gasoek One", size: 20))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                            }
                        }
                        ProgressView("", value: instructionProgress, total: instructionProgressMax).progressViewStyle(gradientStyle).padding(.horizontal,9)
                            .onReceive(timer) { _ in
                                if instructionProgress > 0 {
                                    instructionProgress -= 0.1
                                }
                            }.frame(width: 400 ,height: 60,alignment:.bottom).ignoresSafeArea(.all)
                    }
                    Spacer()
                    Spacer()
                }
                .padding(.vertical,50)
                RecapSceneView(lives: $lives, show: $showPopUp, isStartGame: $isStartGame)
            }
            .onAppear {
                for (index, player) in gameService.party.players.enumerated() {
                    if player.role == Role.lookout {
                        instructionProgress = gameService.party.players[index].event.duration
                        instructionProgressMax = gameService.party.players[index].event.duration
                    }
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
                        if player.role == Role.helmsman {
                            instructionProgress = gameService.party.players[index].event.duration
                            instructionProgressMax = gameService.party.players[index].event.duration
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
        }
        
    }
    
    var popUpView: some View {
        ZStack{
            Rectangle().opacity(0.5).ignoresSafeArea()
            switch choose {
            case "sailingmaster":
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 348, height: 514)
                    .background(
                        Image("VerticalMap")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 348, height: 514)
                            .clipped()
                    ).offset(y:70)
                Button{
                    
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 224.93666, height: 57.58378)
                        .background(
                            ZStack{
                                Image("InfoBox")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 224.93666076660156, height: 57.58378219604492)
                                    .clipped()
                                Text("Fix Sail 1")
                                    .font(
                                        Font.custom("Krub-Regular", size: 24)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 127.11892, height: 35.85405, alignment: .top)
                            }
                        )
                }.offset(y:-30)
                Button{
                    
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 224.93666, height: 57.58378)
                        .background(
                            ZStack{
                                Image("InfoBox")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 224.93666076660156, height: 57.58378219604492)
                                    .clipped()
                                Text("Fix Sail 2")
                                    .font(
                                        Font.custom("Krub-Regular", size: 24)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 127.11892, height: 35.85405, alignment: .top)
                            }
                        )
                }.offset(y:50)
                Button{
                    
                } label: {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 224.93666, height: 57.58378)
                        .background(
                            ZStack{
                                Image("InfoBox")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 224.93666076660156, height: 57.58378219604492)
                                    .clipped()
                                Text("Fix Sail 3")
                                    .font(
                                        Font.custom("Krub-Regular", size: 24)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .frame(width: 127.11892, height: 35.85405, alignment: .top)
                            }
                        )
                }.offset(y:130)
                
            case "helmsman":
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
                
            case "lookput":
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
        CabinBoyView(isStartGame: .constant(false), partyId: UUID()).environmentObject(GameService())
    }
}
