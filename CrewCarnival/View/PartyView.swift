//
//  PartyView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 21/06/23.
//

import SwiftUI

struct PartyView: View {
    @State var name: String = ""
    @EnvironmentObject var gameService: GameService
    @State var partyId: UUID = UUID()
    @Environment(\.presentationMode) var presentation
    @Binding var menu: Int
    
    func createParty() {
        var party = Party()
        partyId = party.id
        
        gameService.currentPlayer.name = name
        gameService.currentPlayer.role = Role.lookout
        
        party.players.append(gameService.currentPlayer)
        gameService.parties.append(party)
    }
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            if gameService.currentPlayer.name == "" {
                ZStack{
                    Image("MenuBackground").resizable().scaledToFill().ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("EnterName")
                            .resizable()
                            .frame(width: 305, height: 100)
                        TextField("Enter your name", text: $name)
                            .textFieldStyle(.plain)
                            .font(.system(size: 20))
                            .padding(10)
                            .background(.white)
                            .padding(20)
                        Spacer()
                            .frame(height: 80)
                        Button {
                            gameService.currentPlayer.name = name
                        } label: {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 218, height: 84)
                              .background(
                                Image("Submit")
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  .frame(width: 218, height: 84)
                                  .clipped()
                              )
                        }
                        Spacer()
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                menu = -1
                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                        }
                    }
                }
            } else {
                ZStack{
                    Image("BackgroundSelect").resizable().scaledToFill().ignoresSafeArea()
                    ScrollView{
                        VStack{
                            Image("SelectRoom")
                                .resizable()
                                .frame(width: 320, height: 105)
                                .padding(.vertical, 50)
                            if gameService.parties.count > 0 {
                                LazyHGrid(rows: rows, spacing: 20) {
                                    ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                                        PartyCard(partyIndex: index, party: party, name: $name)
                                    }
                                }
                                .padding(20)
                            } else {
                                Text("No party available, create a party!")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            NavigationLink {
                                ReadyView(partyId: partyId)
                            } label: {
                                Text("Create Party")
                                    .foregroundColor(.yellow)
                                    .fontWeight(.bold)
                                    .frame(
                                        minWidth: 0,
                                        maxWidth: .infinity
                                    )
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.black))
                                    .padding()
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                self.createParty()
                                self.gameService.send(parties: gameService.parties)
                            })
                            .navigationBarBackButtonHidden(true)
                        }
                    }
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarLeading) {
//                            Button {
//                                gameService.currentPlayer.name = ""
//                            } label: {
//                                HStack {
//                                    Image(systemName: "chevron.backward")
//                                    Text("Back")
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        PartyView(menu: .constant(0)).environmentObject(GameService())
    }
}
