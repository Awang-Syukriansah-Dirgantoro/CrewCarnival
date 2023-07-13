//
//  StoryView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 13/07/23.
//

import SwiftUI

struct StoryView: View {
    @State var numStory: Int = 1
    @State var timeStory = 5.9
    @State var timeStory2 = 5.9
    @State var timeStory3 = 5.9
    @State var timeStory4 = 5.9
    @State var timeStory5 = 5.9
    @State var timeStory6 = 7.9
    @State var looks:String = "scene1"
    @State var looks2:String = "scene2"
    @State var looks4:String = "scene4"
    @State var looks5:String = "scene5"
    @State var looks6:String = "scene6"
    @Binding var showStory: Bool
    @Binding var roleExplain: Bool
    @EnvironmentObject var gameService: GameService
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            
            if numStory == 1 {
                PlayerView(look: $looks).ignoresSafeArea().onReceive(timer) { _ in
                    timeStory -= 0.1
                    if timeStory <= 1.1 {
                        timeStory = 0
                        numStory = 2
                    }
                }
                ZStack{
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.2))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 70)
                    Text("Your crew is renowned as the wealthiest pirates across the seven seas. You thrive on seeking out treasures brimming with obstacles and challenges. With your unwavering strategy, you have consistently triumphed in discovering every treasure.")
                        .font(Font.custom("Krub-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 70)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
            } else if numStory == 2 {
                PlayerView(look: $looks2).ignoresSafeArea().onReceive(timer) { _ in
                    timeStory2 -= 0.1
                    if timeStory2 <= 1.1 {
                        timeStory2 = 0
                        numStory = 3
                    }
                }
                ZStack{
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.12))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 70)
                    Text("One fateful day, your crew received word of an island known as \"The Crush Island\"")
                        .font(Font.custom("Krub-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 70)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
            } else if numStory == 3 {
                ZStack{
                    Image("Scene3").resizable()
                        .scaledToFill().onReceive(timer) { _ in
                            timeStory3 -= 0.1
                            if timeStory3 <= 1.1 {
                                timeStory3 = 0
                                numStory = 4
                            }
                        }
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.16))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 80)
                    Text("Legends whispered that this island safeguarded a treasure passed down through seven generations. The island stands as an extraordinary haven, remarkably secluded and distant from your crew's camp.")
                        .font(Font.custom("Krub-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 80)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
                .ignoresSafeArea()
            } else if numStory == 4 {
                PlayerView(look: $looks4).ignoresSafeArea().onReceive(timer) { _ in
                    timeStory4 -= 0.1
                    if timeStory4 <= 1.1 {
                        timeStory4 = 0
                        numStory = 5
                    }
                }
                ZStack{
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.11))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 70)
                    Text("You have treasure, you have power")
                        .font(Font.custom("Krub-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 70)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
            } else if numStory == 5 {
                PlayerView(look: $looks5).ignoresSafeArea().onReceive(timer) { _ in
                    timeStory5 -= 0.1
                    if timeStory5 <= 1.1 {
                        timeStory5 = 0
                        numStory = 6
                    }
                }
                ZStack{
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.17))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 70)
                    Text("You and your crew immediately went off to explore the ocean in search of The Crush Island. Along the journey, multiple obstacles must be overcome, requiring all crew members to collaborate and work together in order to overcome them.")
                        .font(Font.custom("Krub-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 70)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
            } else if numStory == 6 {
                PlayerView(look: $looks6).ignoresSafeArea().onReceive(timer) { _ in
                    timeStory6 -= 0.1
                    if timeStory6 <= 1.1 {
                        timeStory6 = 0
                        for (index, player) in gameService.party.players.enumerated() {
                            if player.id == gameService.currentPlayer.id {
                                gameService.party.players[index].isSkipStory = true
                                gameService.send(party: gameService.party)
                                break
                            }
                        }
                    }
                }
                ZStack{
                    Image("BoxStory")
                        .resizable()
                        .frame(width: size.width - (size.width/10), height: size.height - (size.height/1.2))
                        .padding(.horizontal, 20)
                        .position(x: size.width/2, y: size.height - 70)
                    Text("Numerous other ships are also in search of The Crush Island, thus necessitating the carnival crew's swift discovery of the island before their competitors. You must effectively collaborate and overcome the obstacles together as fast as possible.")
                        .font(Font.custom("Krub-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .frame(width: size.width - (size.width/5))
                        .position(x: size.width/2, y: size.height - 70)
                    HStack(alignment: .center) {
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if player.id == gameService.currentPlayer.id {
                                if !player.isSkipStory {
                                    Text("Press to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.orange)
                                        .onTapGesture {
                                            for (index, player) in gameService.party.players.enumerated() {
                                                if player.id == gameService.currentPlayer.id {
                                                    gameService.party.players[index].isSkipStory = true
                                                    gameService.send(party: gameService.party)
                                                    break
                                                }
                                            }
                                        }
                                } else {
                                    Text("Waiting to Skip")
                                        .font(.custom("Gasoek One", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        ForEach(Array(gameService.party.players.enumerated()), id: \.offset) { index, player in
                            if !player.isSkipStory {
                                Image(systemName: "person")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .position(x: size.width/2, y: size.height - 180)
                }
            }
        }
        .onChange(of: gameService.party) { newValue in
            var allPlayerSkip = true
            for (_, player) in gameService.party.players.enumerated() {
                if !player.isSkipStory {
                    allPlayerSkip = false
                }
            }
            
            if allPlayerSkip {
                showStory = false
                roleExplain = false
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(showStory: .constant(false), roleExplain: .constant(false))
            .environmentObject(GameService())
    }
}
