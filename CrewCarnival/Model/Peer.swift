//
//  Peer.swift
//  CrewCarnival
//
//  Created by Yap Justin on 05/07/23.
//

import Foundation
import MultipeerConnectivity

struct Peer {
    var partyId: UUID
    var peerId: MCPeerID?
    var name: String
}
