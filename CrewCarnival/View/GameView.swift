//
//  GameView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 26/06/23.
//

import SwiftUI
import AVKit

struct GameView: View {
    @StateObject var vm = AudioViewModel()
    @EnvironmentObject var gameService: GameService
    @Binding var isStartGame: Bool
    
    var body: some View {
        VStack {
            ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                if player.id == gameService.currentPlayer.id {
                    if player.role == Role.lookout {
                        LookoutView(isStartGame: $isStartGame)
//                        CabinBoyView(isStartGame: $isStartGame)
                    } else if player.role == Role.helmsman  {
                        HelmsmanView(isStartGame: $isStartGame)
//                        CabinBoyView(isStartGame: $isStartGame)
                    } else if player.role == Role.sailingMaster  {
                        SailingMasterView(isStartGame: $isStartGame)
//                        CabinBoyView(isStartGame: $isStartGame)
                    } else if player.role == Role.cabinBoy  {
                        CabinBoyView(isStartGame: $isStartGame)
                    } else {
                        BlacksmithView(isStartGame: $isStartGame)
                    }
                }
            }
        }
        .onAppear {
            vm.playSound(url: "game")
            gameService.party.generateLHSEvent()
            gameService.send(party: gameService.party)
        }
        .toolbar(.hidden)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isStartGame: .constant(false)).environmentObject(GameService())
    }
}
