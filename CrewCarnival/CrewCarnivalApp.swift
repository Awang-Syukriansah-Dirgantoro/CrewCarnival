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
    var body: some Scene {
        WindowGroup {
            HelmsmanView()
        }
    }
}
