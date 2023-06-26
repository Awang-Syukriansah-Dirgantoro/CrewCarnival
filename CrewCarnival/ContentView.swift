//
//  ContentView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameService:GameService
    var body: some View {
        NavigationView {
            MenuView()
                .onAppear {
                    self.gameService.delegate = self
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView : GameServiceDelegate {
    
    func connectedDevicesChanged(manager: GameService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
        }
    }
    
    func partiesChanged(manager: GameService, data: Data) {
        OperationQueue.main.addOperation {
            do {
                self.gameService.parties = try JSONDecoder().decode([Party].self, from: data)
            } catch let error {
                print("Error decoding: \(error)")
            }
            self.gameService.parties = gameService.parties
            print("cek2:\(self.gameService.parties)")
        }
    }
}
