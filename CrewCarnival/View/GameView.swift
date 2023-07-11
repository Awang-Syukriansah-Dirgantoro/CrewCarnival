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
    @Binding var isStartGame: Bool
    @State var role:Role?
    
    var body: some View {
        VStack {
           
                if role == Role.lookout {
                    LookoutView(isStartGame: $isStartGame)
                } else if role == Role.helmsman  {
                    HelmsmanView(isStartGame: $isStartGame)
                } else if role == Role.sailingMaster  {
                    SailingMasterView(isStartGame: $isStartGame)
                } else if role == Role.cabinBoy  {
                    CabinBoyView(isStartGame: $isStartGame)
                } else {
                    BlacksmithView(isStartGame: $isStartGame)
                }
            
        }
        .onAppear {
            gameService.party.generateLHSEvent()
            gameService.send(party: gameService.party)
            for player in gameService.party.players{
                if player.id == gameService.currentPlayer.id {
                    role = player.role
                }
            }
        }
        .toolbar(.hidden)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isStartGame: .constant(false))
    }
}
