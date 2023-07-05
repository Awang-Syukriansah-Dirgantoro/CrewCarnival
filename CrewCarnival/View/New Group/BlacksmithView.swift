//
//  BlacksmithView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 24/06/23.
//

import SwiftUI

struct BlacksmithView: View {
    @StateObject var vm = PuzzleViewModel()
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    @State private var roleExplain = false
    @State var timeExplain = 100
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var body: some View {
        if roleExplain == false{
            Image("blacksmithExplain").edgesIgnoringSafeArea(.all).onReceive(timer) { _ in
                timeExplain -= 1
                if timeExplain == 0 {
                    roleExplain = true
                }
            }
        }else{
            let gradientStyle = GradientProgressStyle(
                stroke: .clear,
                fill: gradient,
                caption: ""
            )
            ZStack{
                
                Image("BgBlacksmith")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                VStack{
                    HStack{
                        Text("Blacksmith")
                            .font(.custom("Gasoek One", size: 24))
                            .foregroundColor(.white)
                        Spacer()
                        HStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 25, height: 19)
                                .background(
                                    Image("Heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 25, height: 19)
                                        .clipped()
                                )
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 25, height: 19)
                                .background(
                                    Image("Heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 25, height: 19)
                                        .clipped()
                                )
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 25, height: 19)
                                .background(
                                    Image("Heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 25, height: 19)
                                        .clipped()
                                )
                        }
                    }.padding(.horizontal, 30)
                        .padding(.top, 30)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 334, height: 27)
                            .background(
                                Image("LoadingBar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 334, height: 27)
                                    .clipped()
                            )
                        ProgressView("", value: downloadAmount, total: 100).progressViewStyle(gradientStyle).padding(.horizontal,9)
                    }.padding(.bottom,20).padding(.horizontal,30)
                    VStack{
                        Text("There are obstacles nearby!")
                            .font(Font.custom("Gasoek One", size: 20))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                            .background(
                                Rectangle()
                                    .opacity(0.5))
                        ProgressView("", value: progressInstruction, total: 100)
                            .onReceive(timer) { _ in
                                if progressInstruction < 100 {
                                    progressInstruction += 0.5
                                }
                            }
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0, green: 0.82, blue: 0.23)))
                            .padding(.top, -30)
                    }
                    ZStack {
                        VStack(alignment: .center, spacing: 30) {
                            Drop(vm: vm)
                                .padding(.vertical,30)
                            Drag(vm: vm)
                        }
                        .padding(.top,30)
                    }
                    .padding()
                    .onAppear {
                        vm.shuffleArray()
                    }
                    .offset(x: vm.animateWrong ? -30 : 0)
                    .environmentObject(vm)
                    Spacer()
                }
            }
        }
    }
}

struct BlacksmithView_Previews: PreviewProvider {
    static var previews: some View {
        BlacksmithView()
    }
}
