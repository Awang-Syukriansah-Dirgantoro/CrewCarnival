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
    
//    func createParty() {
//        var party = Party()
//        partyId = party.id
//
//        gameService.currentPlayer.name = name
//        gameService.currentPlayer.role = Role.lookout
//
//        party.players.append(gameService.currentPlayer)
//        gameService.parties.append(party)
//    }
    
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            if gameService.currentPlayer.name == "" {
                ZStack{
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        Image("MenuBackground").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                    }.ignoresSafeArea()
                    VStack {
                        Spacer()
                        Image("EnterName")
                            .resizable()
                            .frame(width: 305, height: 100)
                        TextField("Enter your name", text: $name, prompt: Text("Enter your name").foregroundColor(Color(UIColor.systemGray4)).font(.system(size: 20)))
                            .textFieldStyle(.plain)
                            .font(.custom("Gasoek One", size: 20))
                            .padding(16)
                            .border(.yellow, width: 4)
                            .shadow(radius: 4)
                            .background(Color(UIColor(red: 117/255, green: 59/255, blue: 51/255, alpha: 1.0)))
                            .foregroundColor(.white)
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
                                Image("BackButton")
                            }
                        }
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                }
            } else {
                ZStack{
                    Image("BackgroundSelect").resizable().scaledToFill().ignoresSafeArea()
                    ScrollView{
                        VStack{
                            if gameService.availablePeers.count > 0 {
                                LazyVGrid(columns: rows, spacing: 20) {
                                    Section {
                                        ForEach(Array(gameService.availablePeers.enumerated()), id: \.offset) { index, peer in
                                            PartyCard(peer: peer)
//                                            NavigationLink {
//                                                ReadyView(partyId: partyId)
//                                            } label: {
//                                                Text("\(peer.partyId)")
//                                            }
//                                            .simultaneousGesture(TapGesture().onEnded {
//                                                gameService.party.id = peer.partyId
//                                                gameService.serviceBrowser.stopBrowsingForPeers()
//                                                gameService.serviceBrowser.startBrowsingForPeers()
//                                            })
                                        }
                                    } header: {
                                        Image("SelectRoom")
                                            .resizable()
                                            .frame(width: 320, height: 105)
                                            .padding(.top, 50)
                                    }
                                }
                                .padding(20)
                            } else {
                                Section {
                                    Text("No party available, create a party!")
                                        .foregroundColor(.gray)
                                        .padding()
                                }  header: {
                                    Image("SelectRoom")
                                        .resizable()
                                        .frame(width: 320, height: 105)
                                        .padding(.top, 100)
                                }
                            }
                            NavigationLink {
                                ReadyView()
                            } label: {
                                Image("CreateRoom")
                                    .padding(.bottom, 80)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                gameService.party = Party()
                                gameService.party.players.append(gameService.currentPlayer)
                                gameService.party.assignRoles()
                                gameService.startAdvertising(partyId: gameService.party.id)
                            })
                            .navigationBarBackButtonHidden(true)
                        }
                        //.background(.green)
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            gameService.currentPlayer.name = ""
                        } label: {
                            Image("BackButton")
                        }
                    }
                }
                .toolbarBackground(.hidden, for: .navigationBar)
            }
        }
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        PartyView(menu: .constant(0)).environmentObject(GameService())
    }
}
