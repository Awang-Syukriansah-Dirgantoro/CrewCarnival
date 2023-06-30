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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack{
            if gameService.currentPlayer.name == "" {
                VStack {
                    Spacer()
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(.plain)
                        .font(.system(size: 20))
                        .padding(20)
                    Button {
                        gameService.currentPlayer.name = name
                    } label: {
                        Text("Submit")
                            .foregroundColor(.yellow)
                            .fontWeight(.bold)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity
                            )
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15)
                                .fill(Color.black))
                            .padding(.horizontal)
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
            } else {
                ScrollView{
                    VStack{
                        if gameService.parties.count > 0 {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(Array(gameService.parties.enumerated()), id: \.offset) { index, party in
                                    PartyCard(partyIndex: index, party: party, name: $name)
                                }
                            }
                            .padding(.horizontal)
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
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            gameService.currentPlayer.name = ""
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        PartyView(menu: .constant(0))
    }
}
