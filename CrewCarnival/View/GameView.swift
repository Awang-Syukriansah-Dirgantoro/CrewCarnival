//
//  GameView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 26/06/23.
//

import SwiftUI

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
                               HelmsmanView()
                            } else if player.role == Role.sailingMaster  {
                                SailingMasterView()
                            } else if player.role == Role.cabinBoy  {
                                
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
                    gameService.parties[index].generateLookoutEvent()
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
