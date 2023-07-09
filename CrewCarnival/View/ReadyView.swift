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
    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                let size = proxy.size
                
                Image("backgroundroom").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
            }.ignoresSafeArea()
            
            Text("Waiting For \n Players").font(.custom("Gasoek One", size: 30)).foregroundColor(.white).offset(y: -200).multilineTextAlignment(.center).shadow(color: .yellow, radius: 5)
            VStack {
                if isStartGame {
                    GameView(isStartGame: $isStartGame)
                } else {
                    VStack() {
                        HStack(alignment: .top) {
                            ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                                VStack() {
                                    Text("\(player.name )")
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.black).bold().font(.system(size: 20)).shadow(color: .yellow, radius: 1).offset(y: -5)
                                    Image(player.getStringRole() == "Sailing Master" ? "SailMaster" : player.getStringRole() == "Cabin Boy" ? "CabinBoy" : "\(player.getStringRole() )").offset(y: player.getStringRole() == "Sailing Master" ? 0 : player.getStringRole() == "Blacksmith" ? 0 : 18)
                                    
                                    Image("tickbtn").offset(y: player.getStringRole() == "Sailing Master" ? 30 : player.getStringRole() == "Blacksmith" ? 30 : 48).opacity(player.isReady ? 1 : 0)
                                    
                                    
                                }.frame(minWidth: 0, maxWidth: .infinity)
                            }
                            Spacer()
                        }
                        .padding()
                        Button {
                            for (index, player) in gameService.party.players.enumerated() {
                                if player.id == gameService.currentPlayer.id {
                                    gameService.party.players[index].isReady.toggle()
                                }
                            }
                            self.gameService.send(party: gameService.party)
                        } label: {
                            Image("readybtn")
                        }.offset(y:70)
                    }.offset(y: 60)
                        .onChange(of: gameService.party, perform: { newValue in
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
                                gameService.party.isPlaying = true
                                
                                self.gameService.send(party: gameService.party)
                                
                                isStartGame = true
                            }
                        })
                }
            }
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
            }
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView().environmentObject(GameService())
    }
}
