//
//  FirstView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 30/06/23.
//

import SwiftUI

struct FirstView: View {
    @ObservedObject var vm = AudioViewModel()
    @State private var showLight = false
    @State private var play = false
    @State private var animation = 1.0
    @State private var animationTransition = 1.0
    @State private var degrees = 0.0
    @State private var degreesTransition = 0.0
    @State var timer = Timer.publish(every: 2, on: .main, in: .common)
    
    var body: some View {
        ZStack{
            if play == true {
                MenuView()
            }
            else {
                ZStack{
                    Image("BgHome")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    Image("Light")
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                        .clipped()
                        .scaleEffect(animation+0.2)
                        .rotationEffect(Angle.degrees(degrees))
                        .animation(
                            .easeInOut(duration: 1.5),
                            value: animation)
                        .onAppear{
                            animation += 0.5
                            self.degrees += 300
                        }
                        .offset(y:-200)
                    Image("Logo")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .clipped()
                        .scaleEffect(animation+0.2)
                        .animation(
                            .easeInOut(duration: 1.5),
                            value: animation)
                        .onAppear{
                            animation += 0.5
                        }
                        .offset(y:-240)
                    Button{
                        play = true
                    } label : {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(
                                Image("ButtonPlay")
                                    .resizable()
                                    .frame(width: 175, height: 170)
                            )
                            .offset(y: 20)
                    }
                }
            }
        }
        .onAppear{
            vm.playSound(url: "menu")
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
