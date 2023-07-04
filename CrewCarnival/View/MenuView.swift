//
//  MenuView.swift
//  CrewCarnival
//
//  Created by Yap Justin on 24/06/23.
//

import SwiftUI
import AVKit

struct MenuView: View {
    @State var menu = -1
    
    var body: some View {
        if menu == 0 {
            PartyView(menu: $menu)
        } else if menu == 1 {
            AllRole(menu: $menu)
        } else {
            ZStack{
                Image("MenuBackground").resizable().scaledToFill().ignoresSafeArea()
                VStack {
                    Spacer()
                    Button {
                        menu = 0
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 246.45351, height: 94.54269)
                            .background(
                                Image("ButtonMenuPlay")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 246.45350646972656, height: 94.54268646240234)
                                    .clipped()
                            )
                    }
                    Button {
                        menu = 1
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 246.45351, height: 94.54269)
                            .background(
                                Image("ButtonMenuRoles")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 246.45350646972656, height: 94.54268646240234)
                                    .clipped()
                            )
                    }
                    Button {
                        menu = 1
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 246.45351, height: 94.54269)
                            .background(
                                Image("ButtonMenuHowToPlay")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 246.45350646972656, height: 94.54268646240234)
                                    .clipped()
                            )
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
