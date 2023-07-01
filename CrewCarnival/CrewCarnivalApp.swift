//
//  CrewCarnivalApp.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

@main
struct CrewCarnivalApp: App {
    @StateObject var gameService = GameService()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameService)
//                .onReceive(timer) { time in
//                    gameService.send(parties: gameService.parties)
//                }
        }
    }
}
