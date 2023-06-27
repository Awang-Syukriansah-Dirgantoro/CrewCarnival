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
            Image("CabinBoyBack").resizable().scaledToFill().ignoresSafeArea(.all).offset(x:xOffset)
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
                    ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                        if party.id == partyId {
                            ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                if gameService.currentPlayer.id == player.id {
                                    Text("\(gameService.parties[index].players[index2].event.instruction)")
                                        .font(Font.custom("Gasoek One", size: 20))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                                }
                            }
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
            Button{
                
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
            }.offset(x:-50,y:-60)
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
            }.offset(y:140)
            Button{
                
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
            }.offset(x:-130,y:190)
            Button{
                
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
            }.offset(x:130,y:240)
        }
        .onAppear {
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    gameService.parties[index].generateLookoutEvent()
                    for (index2, player) in gameService.parties[index].players.enumerated() {
                        if player.role == Role.lookout {
                            instructionProgress = gameService.parties[index].players[index2].event.duration
                            instructionProgressMax = gameService.parties[index].players[index2].event.duration
                        }
                    }
                }
            }
        }
    }
}

struct CabinBoyView_Previews: PreviewProvider {
    static var previews: some View {
        CabinBoyView(partyId: UUID())
            .environmentObject(GameService())
    }
}
