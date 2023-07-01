//
//  PartyCard.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import SwiftUI

struct PartyCard: View {
    var partyIndex: Int
    var party: Party
    @Binding var name: String
    @EnvironmentObject var gameService: GameService
    @State var cardText = ""
    
    let columns = [
        GridItem(.flexible()),
                GridItem(.flexible()),
        ]
    
    var body: some View {
        if party.isPlaying {
            VStack {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(party.players.enumerated()), id: \.offset) { index, player in
                        Text("\(player.name)")
                    }
                }
                .padding(16)
                .background(.white)
                .cornerRadius(16)
                .shadow(radius: 4)
                Text(cardText)
                Button {
                    for (index, party) in gameService.parties.enumerated() {
                        if party.id == self.party.id {
                            gameService.parties.remove(at: index)
                            self.gameService.send(parties: gameService.parties)
                            break
                        }
                    }
                } label: {
                    Text("Delete (Debug Only)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.red))
                        .padding(.horizontal)
                }
            }
            .onAppear {
                if party.isPlaying {
                    cardText = "Currently Playing"
                } else {
                    if party.players.count == 1 {
                        cardText = "\(party.players.count) Player"
                    } else {
                        cardText = "\(party.players.count) Players"
                    }
                }
            }
            .onChange(of: party) { party in
                if party.isPlaying {
                    cardText = "Currently Playing"
                } else {
                    if party.players.count == 1 {
                        cardText = "Join - \(party.players.count) Player"
                    } else {
                        cardText = "Join - \(party.players.count) Players"
                    }
                }
            }
        } else {
            NavigationLink {
                ReadyView(partyId: party.id)
                    .environmentObject(self.gameService)
            } label: {
                VStack {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(party.players.enumerated()), id: \.offset) { index, player in
                            Text("\(player.name)")
                        }
                    }
                    .padding(16)
                    .background(.white)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    Text(cardText)
                    Button {
                        for (index, party) in gameService.parties.enumerated() {
                            if party.id == self.party.id {
                                gameService.parties.remove(at: index)
                                self.gameService.send(parties: gameService.parties)
                                break
                            }
                        }
                    } label: {
                        Text("Delete (Debug Only)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity
                            )
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .fill(Color.red))
                            .padding(.horizontal)
                    }
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                print(partyIndex)
                gameService.currentPlayer.name = name
                gameService.currentPlayer.role = Role.lookout
                
                gameService.parties[partyIndex].players.append(gameService.currentPlayer)
                
                self.gameService.send(parties: gameService.parties)
            })
            .onAppear {
                if party.isPlaying {
                    cardText = "Currently Playing"
                } else {
                    if party.players.count == 1 {
                        cardText = "\(party.players.count) Player"
                    } else {
                        cardText = "\(party.players.count) Players"
                    }
                }
            }
            .onChange(of: party) { party in
                if party.isPlaying {
                    cardText = "Currently Playing"
                } else {
                    if party.players.count == 1 {
                        cardText = "Join - \(party.players.count) Player"
                    } else {
                        cardText = "Join - \(party.players.count) Players"
                    }
                }
            }
        }
    }
}

struct PartyCard_Previews: PreviewProvider {
    static var previews: some View {
        PartyCard(partyIndex: 0, party: Party(players: [Player(name: "aaa", role: Role.lookout)]), name: .constant(""))
            .environmentObject(GameService())
    }
}
