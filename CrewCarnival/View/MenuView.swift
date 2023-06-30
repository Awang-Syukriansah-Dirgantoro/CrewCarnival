//
//  MenuView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 24/06/23.
//

import SwiftUI
import AVKit

struct MenuView: View {
    @ObservedObject var vm = AudioViewModel()
    @State var menu = -1
    
    var body: some View {
        VStack {
            if menu == 0 {
                PartyView(menu: $menu)
            } else if menu == 1 {
                
            } else {
                VStack {
                    Spacer()
                    Button {
                        menu = 0
                    } label: {
                        Text("Play")
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
                    Button {
                        menu = 1
                    } label: {
                        Text("Tutorial")
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
            }
        }
        .onAppear{
            vm.playSound(url: "menu")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
