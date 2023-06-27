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
    @State var partyIndex = 0
    @State var isStartGame = false
    
    var body: some View {
        VStack {
            if isStartGame {
                GameView(partyId: partyId)
            } else {
                VStack() {
                    HStack(alignment: .top) {
                        ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                            if party.id == partyId {
                                ForEach(Array(party.players.enumerated()), id: \.offset) { index2, player in
                                    VStack {
                                        Text("\(player.name )")
                                            .multilineTextAlignment(.leading)
                                            .bold()
                                        Image(systemName: "figure.stand")
                                            .font(.system(size: 60))
                                        if player.isReady {
                                            Image(systemName: "checkmark.circle.fill")
                                        }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
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
                    
                }
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

struct ReadyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyView(partyId: UUID())
    }
}
