//
//  LookoutView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 22/06/23.
//

import SwiftUI

struct LookoutView: View {
    @State private var downloadAmount = 80.0
    @State private var progressInstruction = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0, green: 0.82, blue: 0.23)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    @State private var xOffset:CGFloat = 0
    @State private var isMove = false
    @State private var direction = "Forward"
    @State private var isLeftAble = true
    @State private var isRightAble = true
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        ZStack{
            Image("LookoutBack").resizable().scaledToFill().ignoresSafeArea(.all).offset(x:xOffset)
            VStack{
                HStack{
                    Text("Lookout")
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
                }.padding(.bottom).padding(.horizontal,30)
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
                    ProgressView("", value: progressInstruction, total: 100)
                        .onReceive(timer) { _ in
                            if progressInstruction < 100 && isMove{
                                progressInstruction += 1
                            }
                            if progressInstruction == 100 {
                                isMove = false
                                progressInstruction = 0
                                if xOffset == 393 {
                                    isLeftAble = false
                                    isRightAble = true
                                } else if xOffset == -393 {
                                    isLeftAble = true
                                    isRightAble = false
                                } else {
                                    isLeftAble = true
                                    isRightAble = true
                                }
                            }
                        }
                        .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 0, green: 0.82, blue: 0.23))).frame(height: 60, alignment:.bottom)
                }
                Spacer()
                ZStack{
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 247, height: 66)
                        .background(
                            Image("InfoBox")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 247, height: 66)
                                .clipped()
                        )
                    Text("You are looking at: \(direction) Direction")
                        .font(Font.custom("Krub-Regular", size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white).frame(width: 247, height: 66)
                }
                HStack{
                    Spacer()
                    Button{
                        isMove = true
                        isLeftAble = false
                        isRightAble = false
                        withAnimation (Animation.easeOut (duration: 10)){
                        xOffset = xOffset + 393
                        }
                        if xOffset == 0 {
                            direction = "Forward"
                        } else {
                            direction = "Left"
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 125.51723, height: 129.99998)
                            .background(
                                Image("ButtonLeft")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 125.5172348022461, height: 129.99998474121094)
                                    .clipped()
                            )
                    }.disabled(!isLeftAble)
                    Spacer()
                    Button{
                        isMove = true
                        isLeftAble = false
                        isRightAble = false
                        withAnimation (Animation.easeOut (duration: 10)){
                        xOffset = xOffset - 393
                        }
                        if xOffset == 0 {
                            direction = "Forward"
                        } else {
                            direction = "Right"
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 125.51723, height: 129.99998)
                            .background(
                                Image("ButtonRight")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 125.5172348022461, height: 129.99998474121094)
                                    .clipped()
                            )
                    }.disabled(!isRightAble)
                    Spacer()
                }
            }
            .padding(.vertical,50)
        }
    }
}

struct LookoutView_Previews: PreviewProvider {
    static var previews: some View {
        LookoutView()
    }
}
