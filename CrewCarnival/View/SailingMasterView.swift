//
//  SailingMasterView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct SailingMasterView: View {
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
        ZStack{
            Image("Sail").resizable().scaledToFill().ignoresSafeArea(.all)
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
                }.padding(.top, 40).padding(.horizontal,30)
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
                    Rectangle().frame(height: 60).opacity(0.5)
                    Text("There are obstacles nearby!")
                        .font(Font.custom("Gasoek One", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                    Rectangle()
                        .frame(height: 5)
                        .offset(y: 30)
                        .foregroundColor(Color(red: 0, green: 0.82, blue: 0.23))
                }
                Spacer()
            }
        }.background(Image("BgSailingMaster").resizable().scaledToFill())
    }
}

struct SailingMasterView_Previews: PreviewProvider {
    static var previews: some View {
        SailingMasterView()
    }
}
