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
                    ZStack{
                        Image("Room").resizable().frame(width: 280, height: 120).ignoresSafeArea()
                        ForEach(Array(party.players.enumerated()), id: \.offset) { index, player in
                            Text("\(player.name)")
                        }
                    }
                    .padding(16)
                    .cornerRadius(16)
                    .shadow(radius: 4)
                    Text(cardText)
                }
            }
            .simultaneousGesture(TapGesture().onEnded {
                print(partyIndex)
                gameService.currentPlayer.name = name
                gameService.currentPlayer.role = Role.lookout
                
                gameService.party.players.append(gameService.currentPlayer)
                
                self.gameService.send(party: gameService.party)
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
