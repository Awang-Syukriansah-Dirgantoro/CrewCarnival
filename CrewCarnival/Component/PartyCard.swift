//
//  PartyCard.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import SwiftUI
import MultipeerConnectivity

struct PartyCard: View {
    var peer: Peer
    @EnvironmentObject var gameService: GameService
    var random = Int.random(in: 0...4)
    
    var body: some View {
        NavigationLink {
            ReadyView()
        } label: {
            VStack {
                ZStack{
                    Image("Room").resizable().frame(width: 340, height: 120)
                    if random == 0 {
                        Image("SailMaster")
                            .resizable().frame(width: 35, height: 80)
                    } else if random == 1 {
                        Image("Blacksmith")
                            .resizable().frame(width: 35, height: 80)
                    } else if random == 2 {
                        Image("CabinBoy")
                            .resizable().frame(width: 35, height: 80)
                    } else if random == 3 {
                        Image("Lookout")
                            .resizable().frame(width: 35, height: 80)
                    } else {
                        Image("Helmsman")
                            .resizable().frame(width: 35, height: 80)
                    }
                }
                .shadow(radius: 4)
                Text("Join \(peer.name)'s Crew")
                    .font(.custom("Gasoek One", size: 18))
                    .foregroundColor(.orange)
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(TapGesture().onEnded {
            gameService.party.id = peer.partyId
            gameService.serviceBrowser.stopBrowsingForPeers()
            gameService.serviceBrowser.startBrowsingForPeers()
        })
    }
}

struct PartyCard_Previews: PreviewProvider {
    static var previews: some View {
        PartyCard(peer: Peer(partyId: UUID(), name: "A"))
    }
}
