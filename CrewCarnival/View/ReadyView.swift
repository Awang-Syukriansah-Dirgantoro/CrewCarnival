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
                GameView(partyId: partyId, isStartGame: $isStartGame)
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
                    Spacer()
                    .onChange(of: gameService.party, perform: { newValue in
                        var areAllPlayersReady = true
                        
                        for (_, player) in gameService.party.players.enumerated() {
                            if !player.isReady {
                                areAllPlayersReady = false
                            }
                        }
                        
                        if areAllPlayersReady {
                            gameService.party.isPlaying = true
                            
                            self.gameService.send(party: gameService.party)
                            
                            isStartGame = true
                        }
                    })
                    .onAppear {
                        gameService.currentPlayer.role = Role.lookout
                        
                        gameService.party.players.append(gameService.currentPlayer)
                        
                        gameService.party.assignRoles()
                        
                        self.gameService.send(party: gameService.party)
                    }
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

            gameService.serviceAdvertiser.stopAdvertisingPeer()
//            gameService.availablePeers = []
            self.gameService.send(party: gameService.party)
        }
    }
}

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView(partyId: UUID())
    }
}
