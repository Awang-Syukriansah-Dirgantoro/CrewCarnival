//
//  RPSMultipeerSession.swift
//  RPS
//
//  Created by Joe Diragi on 7/28/22.
//

import MultipeerConnectivity
import os

class GameService: NSObject, ObservableObject {
    private let serviceType = "crew-carnival"
    private var myPeerID: MCPeerID
    
    public var serviceAdvertiser: MCNearbyServiceAdvertiser
    public var serviceBrowser: MCNearbyServiceBrowser
    public var session: MCSession
        
    private let log = Logger()
    
    @Published var isAdvertiser = false
    @Published var party: Party
    @Published var currentPlayer: Player
    @Published var availablePeers: [Peer] = []
    @Published var recvdInvite: Bool = false
    @Published var recvdInviteFrom: MCPeerID? = nil
    @Published var paired: Bool = false
    @Published var invitationHandler: ((Bool, MCSession?) -> Void)?
    
    override init() {
        self.party = Party()
        let playerID = UUID()
        let peerID = MCPeerID(displayName: "\(UIDevice.current.name)-\(playerID)")
        self.currentPlayer = Player(id: playerID, peerDisplayName: peerID.displayName, name: "")
        self.myPeerID = peerID
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        super.init()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
                
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.delegate = nil;
        serviceBrowser.delegate = nil;
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
        session.disconnect()
    }
    
    func startAdvertising(partyId: UUID) {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: ["partyId": "\(party.id)"], serviceType: serviceType)
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        isAdvertiser = true
    }
    
    func send(party: Party) {
        if !session.connectedPeers.isEmpty {
            do {
                let data = try JSONEncoder().encode(party)
                
                NSLog("%@", "sendParties: \(party) to \(session.connectedPeers.count) peers,\(session.connectedPeers.self)")

                if session.connectedPeers.count > 0 {
                    do {
                        try self.session.send(data, toPeers: session.connectedPeers, with: .reliable)
                    }
                    catch let error {
                        NSLog("%@", "Error for sending: \(error)")
                    }
                }
            } catch let error {
                print("Error encoding: \(error)")
            }
        }
    }
}

extension GameService: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        //TODO: Inform the user something went wrong and try again
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        log.info("didReceiveInvitationFromPeer \(peerID)")
        
        DispatchQueue.main.async {
            invitationHandler(true, self.session)
        }
    }
}

extension GameService: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        //TODO: Tell the user something went wrong and try again
        log.error("ServiceBroser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        log.info("ServiceBrowser found peer: \(peerID)")
        // Add the peer to the list of available peers
        DispatchQueue.main.async {
            for peer in self.availablePeers {
                if peer.peerId == peerID {
                    return
                }
            }
            guard let info = info else {
                return
            }
            self.availablePeers.append(Peer(partyId: UUID(uuidString: info["partyId"]!)!, peerId: peerID))
        }
        
        guard let info = info else {
            return
        }
        
        if party.id == UUID(uuidString: info["partyId"]!)! {
            browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 30)
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("ServiceBrowser lost peer: \(peerID)")
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0.peerId == peerID
            })
        }
    }
}

extension GameService: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID) didChangeState: \(state.rawValue)")
        log.info("connectedpeers \(session.connectedPeers)")
        
        if state == .connected {
            if party.players.count != 0 {
                send(party: party)
            }
            serviceBrowser.stopBrowsingForPeers()
        } else if state == .notConnected {
            DispatchQueue.main.async {
                for (index, player) in self.party.players.enumerated() {
                    if player.peerDisplayName == peerID.displayName {
                        self.party.players.remove(at: index)
                        self.send(party: self.party)
                        break
                    }
                }
            }
            serviceBrowser.startBrowsingForPeers()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        log.info("Received data change")
        DispatchQueue.main.async {
            do {
//                if self.party.players.count == 0 {
//                    self.party = try JSONDecoder().decode(Party.self, from: data)
//                    self.currentPlayer.role = Role.lookout
//                    self.party.players.append(self.currentPlayer)
//                    self.party.assignRoles()
//                    self.send(party: self.party)
//                } else {
                    self.party = try JSONDecoder().decode(Party.self, from: data)
//                }
                print("Decoded data: \(self.party)")
            } catch let error {
                print("Error decoding: \(error)")
            }
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}
