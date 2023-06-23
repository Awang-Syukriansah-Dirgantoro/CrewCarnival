//
//  HelmsmanView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 21/06/23.
//

import SwiftUI

struct HelmsmanView: View {
    @State private var downloadAmount = 80.0
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
                    
                    ZStack{
                        Rectangle()
                            .frame(height: 75)
                            .opacity(0.5)
                        Text("The Ship Is Tilting, Slow\nDown 10 Knots!")
                            .font(Font.custom("Gasoek One", size: 20))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                        Rectangle()
                            .frame(height: 5)
                            .offset(y: 40)
                            .foregroundColor(Color(red: 0, green: 0.82, blue: 0.23))
                    }
                    Image("StearingWheel")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .padding(.top, 150)
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
                            .padding(.bottom, -20)
                        ProgressBar(progress: 100)
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
