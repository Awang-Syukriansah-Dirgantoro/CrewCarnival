//
//  GameView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 26/06/23.
//

import SwiftUI
import AVKit

struct GameView: View {
    @EnvironmentObject var gameService: GameService
    var partyId: UUID
    @Binding var isStartGame: Bool
    
    var body: some View {
        VStack {
            ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                if party.id == partyId {
                    ForEach(Array(party.players.enumerated()), id: \.offset) { index, player in
                        if player.id == gameService.currentPlayer.id {
                            if player.role == Role.lookout {
                                LookoutView(isStartGame: $isStartGame, partyId: partyId)
                            } else if player.role == Role.helmsman  {
                                HelmsmanView(partyId: partyId, isStartGame: $isStartGame)
                            } else if player.role == Role.sailingMaster  {
                                SailingMasterView(isStartGame: $isStartGame, partyId: partyId)
                            } else if player.role == Role.cabinBoy  {
                                Text("cabin")
                            } else {
                                BlacksmithView(partyId: partyId, isStartGame: $isStartGame)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            for (index, party) in gameService.parties.enumerated() {
                if party.id == partyId {
                    gameService.parties[index].generateLHSEvent()
                    gameService.send(parties: gameService.parties)
                }
            }
        }
        .toolbar(.hidden)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(partyId: UUID(), isStartGame: .constant(false))
    }
}
