//
//  SailingMasterView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct SailingMasterView: View {
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    @State private var angle1: CGFloat = 123
    @State private var lastAngle1: CGFloat = 0
    @State private var length : CGFloat = 400
    @State private var angle2: CGFloat = 0
    @State private var lastAngle2: CGFloat = 0
    @State private var angle3: CGFloat = 0
    @State private var lastAngle3: CGFloat = 0
    @State private var offset = CGSize.zero
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            VStack{
                HStack{
                    Text("Sailing Master")
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
                    .padding(.top, 10)
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
                ZStack{
                    VStack{
                        Image("Sail")
                            .resizable()
                            .frame(maxWidth: 350, maxHeight: self.angle1)
                            .padding(.vertical, -5)
                        Image("Sail")
                            .resizable()
                            .frame(maxWidth: 440, maxHeight: 160)
                            .padding(.bottom, -5)
                        Image("Sail")
                            .resizable()
                            .frame(maxWidth: 590, maxHeight: 260)
                            .padding(.bottom, 20)
                    }
                    Image("NoSail")
                        .resizable()
                        .scaledToFill()
                        .padding(-38)
                    VStack{
                        Spacer()
                            .frame(height: 50)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50)
                                .rotationEffect(.degrees(Double(self.angle1)))
                                .gesture(DragGesture()
                                    .onChanged{ v in
                                        var theta = (atan2(v.location.x - self.length / 5, self.length / 5 - v.location.y) - atan2(v.startLocation.x - self.length / 5, self.length / 5 - v.startLocation.y)) * 360 / .pi
                                        print(self.angle1)
                                        self.angle1 = theta + self.lastAngle1
                                    }
                                    .onEnded { v in
                                        self.lastAngle1 = self.angle1
                                    }
                                )
                        }
                        Spacer()
                            .frame(height: 80)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50)
                                .rotationEffect(.degrees(Double(self.angle2)))
                                .gesture(DragGesture()
                                    .onChanged{ v in
                                        var theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                                        if (theta < 0) { theta += 360 }
                                        self.angle2 = theta + self.lastAngle2
                                    }
                                    .onEnded { v in
                                        self.lastAngle2 = self.angle2
                                    }
                                )
                        }
                        Spacer()
                            .frame(height: 120)
                        ZStack{
                            Image("Tuas2")
                                .resizable()
                                .frame(width: 60, height: 60)
                            Image("Tuas1")
                                .resizable()
                                .frame(width: 24, height: 63)
                                .padding(.bottom, 50)
                                .rotationEffect(.degrees(Double(self.angle3)))
                                .gesture(DragGesture()
                                    .onChanged{ v in
                                        var theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                                        if (theta < 0) { theta += 360 }
                                        self.angle3 = theta + self.lastAngle3
                                    }
                                    .onEnded { v in
                                        self.lastAngle3 = self.angle3
                                    }
                                )
                        }
                    }.padding(.trailing, 10)
                    
                }
            }
        }.background(Image("BgSailingMaster").resizable().scaledToFill())
    }
}

struct SailingMasterView_Previews: PreviewProvider {
    static var previews: some View {
        SailingMasterView()
    }
}
