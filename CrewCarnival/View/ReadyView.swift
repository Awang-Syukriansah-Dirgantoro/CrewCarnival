//
//  ReadyView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 22/06/23.
//

import SwiftUI

struct ReadyView: View {
    @EnvironmentObject var gameService: GameService
    var partyId: UUID
    @State var isStartGame = false
    
    var body: some View {
        VStack {
            if isStartGame {
                GameView(isStartGame: $isStartGame)
            } else {
                VStack() {
                    HStack(alignment: .top) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            VStack {
                                Text("\(player.name )")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                                Image(systemName: "figure.stand")
                                    .font(.system(size: 60))
                                if player.isReady {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                Text("\(player.getStringRole() )")
                                    .multilineTextAlignment(.leading)
                                    .bold()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
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
                        print("prn \(gameService.party)")
                    } label: {
                        Text("Ready")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity
                            )
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black))
                            .padding(.horizontal)
                    }
                    Button {
                        var alreadyJoined = false
                        for player in gameService.party.players {
                            if player.id == gameService.currentPlayer.id {
                                alreadyJoined = true
                            }
                        }
                        if !alreadyJoined {
                            gameService.currentPlayer.role = Role.lookout
                            
                            gameService.party.players.append(gameService.currentPlayer)
                            
                            gameService.party.assignRoles()
                            
                            self.gameService.send(party: gameService.party)
                        }
                    } label: {
                        Text("Join")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity
                            )
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black))
                            .padding(.horizontal)
                    }
                    Spacer()
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
        }
        .onDisappear {
            for (index, player) in gameService.party.players.enumerated() {
                if player.id == gameService.currentPlayer.id {
                    gameService.party.players.remove(at: index)
                    break
                }
            }

            self.gameService.send(party: gameService.party)
            if gameService.isAdvertiser {
                gameService.serviceAdvertiser.stopAdvertisingPeer()
                gameService.isAdvertiser = false
            }
            gameService.party = Party()
            gameService.session.disconnect()
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView(partyId: UUID())
    }
}
