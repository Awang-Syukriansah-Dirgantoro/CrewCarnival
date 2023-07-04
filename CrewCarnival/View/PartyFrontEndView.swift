//
//  PartyFrontEndView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 27/06/23.
//

import SwiftUI

struct PartyFrontEndView: View {
    @EnvironmentObject var gameService: GameService
    var partyId: UUID
    @State var partyIndex = 0
    @State var isStartGame = false
    var body: some View {
        ZStack{
            Image("backgroundroom").ignoresSafeArea()
            Text("Waiting For \n Players").font(.custom("Gasoek One", size: 30)).foregroundColor(.white).offset(y: -200).multilineTextAlignment(.center).shadow(color: .yellow, radius: 1)
            VStack {
                if isStartGame {
                    GameView(partyId: partyId, isStartGame: $isStartGame)
                } else {
                    VStack() {
                        HStack(alignment: .top) {
                            ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                                if party.id == partyId {
                                    ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                        VStack() {
                                            Text("\(player.name )")
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.black).bold().font(.system(size: 20)).shadow(color: .yellow, radius: 1).offset(y: -5)
                                            Image(player.getStringRole() == "Sailing Master" ? "SailMaster" : player.getStringRole() == "Cabin Boy" ? "CabinBoy" : "\(player.getStringRole() )").offset(y: player.getStringRole() == "Sailing Master" ? 0 : player.getStringRole() == "Blacksmith" ? 0 : 18)
                                            
                                            Image("tickbtn").offset(y: player.getStringRole() == "Sailing Master" ? 30 : player.getStringRole() == "Blacksmith" ? 30 : 48).opacity(player.isReady ? 1 : 0)
                                            
                                            
                                        }.frame(minWidth: 0, maxWidth: .infinity)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        Button {
                            for (index, party) in gameService.parties.enumerated() {
                                if party.id == partyId {
                                    for (index2, player) in party.players.enumerated() {
                                        if player.id == gameService.currentPlayer.id {
                                            gameService.parties[index].players[index2].isReady.toggle()
                                        }
                                    }
                                }
                            }
                            self.gameService.send(parties: gameService.parties)
                        } label: {
                            Image("readybtn")
                        }.offset(y:70)
                        
                    }.offset(y: 60)
                        .onChange(of: gameService.parties, perform: { newValue in
                            var areAllPlayersReady = true
                            
                            for (_, party) in gameService.parties.enumerated() {
                                if party.id == partyId {
                                    for (_, player) in party.players.enumerated() {
                                        if !player.isReady {
                                            areAllPlayersReady = false
                                        }
                                    }
                                }
                            }
                            
                            if areAllPlayersReady {
                                for (index, party) in gameService.parties.enumerated() {
                                    if party.id == partyId {
                                        gameService.parties[index].isPlaying = true
                                    }
                                }
                                
                                self.gameService.send(parties: gameService.parties)
                                
                                isStartGame = true
                            }
                        })
                        .onAppear {
                            for (index, party) in gameService.parties.enumerated() {
                                if party.id == partyId {
                                    self.partyIndex = index
                                    gameService.parties[index].assignRoles()
                                    
                                    self.gameService.send(parties: gameService.parties)
                                }
                            }
                        }
                }
            }
            .onDisappear {
                for (index, party) in gameService.parties.enumerated() {
                    if party.id == partyId {
                        if party.players.count == 1 {
                            gameService.parties.remove(at: index)
                        } else {
                            for (index2, player) in party.players.enumerated() {
                                if player.id == gameService.currentPlayer.id {
                                    gameService.parties[index].players.remove(at: index2)
                                    break
                                }
                            }
                        }
                        break
                    }
                }
                
                self.gameService.send(parties: gameService.parties)
            }
        }
    }
}

struct PartyFrontEndView_Previews: PreviewProvider {
    static var previews: some View {
        PartyFrontEndView(partyId: UUID())
    }
}
