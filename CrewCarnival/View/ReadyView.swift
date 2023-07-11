//
//  ReadyView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 22/06/23.
//

import SwiftUI

struct ReadyView: View {
    @EnvironmentObject var gameService: GameService
    @State var isStartGame = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var startCountdown = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var countdown = 5.9
    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                let size = proxy.size
                
                Image("backgroundroom").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                
                
                if gameService.party.players.count < 1 {
                    VStack(spacing: 20) {
                        Text("Waiting For \n Players")
                            .font(.custom("Gasoek One", size: 30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.2), radius: 4)
                        Text("You Need 3 Players Minimum To Start the Game")
                            .font(.custom("Gasoek One", size: 16))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.2), radius: 4)
                    }
                    .position(x: size.width / 2 ,y: size.height / 4)
                } else {
                    if !startCountdown {
                        Text("Waiting For All Crew Members To Ready Up")
                            .font(.custom("Gasoek One", size: 24))
                            .offset(y: -200)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.2), radius: 4)
                    } else {
                        VStack {
                            Text("Starting\nThe Game In...")
                                .font(.custom("Gasoek One", size: 30))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .shadow(color: Color.black.opacity(0.2), radius: 4)
                            Text("\(String(String(countdown).first!))")
                                .font(.custom("Gasoek One", size: 60))
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.center)
                                .shadow(color: Color.black.opacity(0.2), radius: 4)
                        }
                        .position(x: size.width / 2 ,y: size.height / 4)
                        .onReceive(timer) { _ in
                            countdown -= 0.1
                            if countdown <= 1.1 {
                                countdown = 0
                                gameService.party.isPlaying = true
                                isStartGame = true
                            }
                        }
                    }
                }
                
                ZStack {
                    if isStartGame {
                        GameView(isStartGame: $isStartGame)
                    } else {
                        ZStack() {
                            VStack{
                                HStack(alignment: .top) {
                                    ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                                        VStack() {
                                            Text("\(player.name )")
                                                .font(.custom("Gasoek One", size: 20))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 1)
                                            Image(player.getStringRole() == "Sailing Master" ? "SailMaster" : player.getStringRole() == "Cabin Boy" ? "CabinBoy" : "\(player.getStringRole() )").offset(y: player.getStringRole() == "Sailing Master" ? 0 : player.getStringRole() == "Blacksmith" ? 0 : 18)
                                            
                                            Image("tickbtn").offset(y: player.getStringRole() == "Sailing Master" ? 30 : player.getStringRole() == "Blacksmith" ? 30 : 48).opacity(player.isReady ? 1 : 0)
                                            
                                            
                                        }.frame(minWidth: 0, maxWidth: .infinity)
                                    }
                                    Spacer()
                                }
                                .padding()
                                
                            }
                            Button {
                                for (index, player) in gameService.party.players.enumerated() {
                                    if player.id == gameService.currentPlayer.id {
                                        gameService.party.players[index].isReady.toggle()
                                    }
                                }
                                self.gameService.send(party: gameService.party)
                            } label: {
                                ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                                    if player.id == gameService.currentPlayer.id {
                                        if player.isReady {
                                            Image("unreadybtn")
                                        } else {
                                            Image("readybtn")
                                        }
                                    }
                                }
                            }.position(x: size.width / 2 ,y: size.height / 1.15)
                        }.navigationBarBackButtonHidden()
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        Image("BackButton")
                                    }
                                }
                            }
                            .toolbarBackground(.hidden, for: .navigationBar)
                        
                    }
                }
            }.ignoresSafeArea()
            .onDisappear {               
                if gameService.isAdvertiser {
                    gameService.serviceAdvertiser.stopAdvertisingPeer()
                    gameService.isAdvertiser = false
                }
                gameService.party = Party()
                gameService.session.disconnect()
            }
            .onChange(of: gameService.party) { newValue in
                if gameService.party.players.count > 0 {
                    var alreadyJoined = false
                    for player in gameService.party.players {
                        if player.id == gameService.currentPlayer.id {
                            alreadyJoined = true
                            break
                        }
                    }
                    if !alreadyJoined {
                        gameService.party.players.append(gameService.currentPlayer)
                        gameService.party.assignRoles()
                        gameService.send(party: gameService.party)
                    }
                }
                
                if gameService.party.players.count >= 0 {
                    var areAllPlayersReady = false
                    
                    for (_, player) in gameService.party.players.enumerated() {
                        if player.isReady {
                            areAllPlayersReady = true
                        } else {
                            areAllPlayersReady = false
                            break
                        }
                    }
                    
                    if areAllPlayersReady {
                        startCountdown = true
                    } else {
                        startCountdown = false
                        countdown = 5.9
                    }
                }
            }
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView().environmentObject(GameService())
    }
}
