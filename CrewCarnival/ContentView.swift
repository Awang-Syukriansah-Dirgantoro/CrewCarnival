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
        FirstView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
