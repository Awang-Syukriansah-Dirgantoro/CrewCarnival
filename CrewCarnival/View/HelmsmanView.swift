//
//  HelmsmanView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 21/06/23.
//

import SwiftUI

struct HelmsmanView: View {
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @State private var progress: CGFloat = 0
    @State private var angle: CGFloat = 0
    @State private var lastAngle: CGFloat = 0
    @State private var length : CGFloat = 400
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        NavigationStack{
            ZStack {
                Image("ShipHelmsman").resizable().scaledToFill().ignoresSafeArea(.all)
                VStack{
                    HStack{
                        Text("Helmsman")
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
                        Text("The Ship Is Tilting, Slow\nDown 10 Knots!")
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
                    Image("StearingWheel")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .rotationEffect(
                            .degrees(Double(self.angle)))
                        .gesture(DragGesture()
                            .onChanged{ v in
                                let theta = (atan2(v.location.x - self.length / 2, self.length / 2 - v.location.y) - atan2(v.startLocation.x - self.length / 2, self.length / 2 - v.startLocation.y)) * 180 / .pi
                                self.angle = theta + self.lastAngle
                                print(self.angle)
                                
                                if (self.angle > 300){
                                    self.angle = 300
                                    self.progress = self.angle
                                } else if (self.angle < 0){
                                    if (self.angle < -300){
                                        self.angle = -300
                                        self.progress = 300
                                    } else {
                                        self.progress = self.angle * (-1)
                                    }
                                }
                                else {
                                    self.progress = self.angle
                                }
                                print(self.angle)
                            }
                            .onEnded { v in
                                self.lastAngle = self.angle
                            }
                        )
                        .offset(y: 150)
        
                    Spacer()
                        .frame(height: 180)
                    VStack{
                        Text("Turn Progress")
                            .font(Font.custom("Krub-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 32)
                            .background(Image("BgTurnProgress")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 125, height: 32)
                                .clipped())
                            .cornerRadius(15)
                            .padding(.bottom, -15)
                        ProgressBar(progress: self.progress)
                    }
                }
            }.background(Image("BgHelmsman").resizable().scaledToFit())
        }
    }
}

struct HelmsmanView_Previews: PreviewProvider {
    static var previews: some View {
        HelmsmanView()
    }
}
