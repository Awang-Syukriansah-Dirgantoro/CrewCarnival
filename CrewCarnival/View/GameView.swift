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
    
    var body: some View {
        VStack {
            ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                if party.id == partyId {
                    ForEach(Array(party.players.enumerated()), id: \.offset) { index, player in
                        if player.id == gameService.currentPlayer.id {
                            if player.role == Role.lookout {
                                LookoutView(partyId: partyId)
                            } else if player.role == Role.helmsman  {
                                HelmsmanView(partyId: partyId)
                            } else if player.role == Role.sailingMaster  {
                                SailingMasterView(partyId: partyId)
                            } else if player.role == Role.cabinBoy  {
                                Text("cabin")
                            } else {
                                BlacksmithView()
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
        GameView(partyId: UUID())
    }
}
