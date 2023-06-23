//
//  LookoutView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 22/06/23.
//

import SwiftUI

struct GradientProgressStyle<Stroke: ShapeStyle, Background: ShapeStyle>: ProgressViewStyle {
    var stroke: Stroke
    var fill: Background
    var caption: String = ""
    var cornerRadius: CGFloat = 10
    var height: CGFloat = 15
    var animation: Animation = .easeInOut
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle()
                        .fill(fill)
                        .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                    //                        .animation(animation)
                }
            }
            .frame(height: height)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(stroke, lineWidth: 2)
            )
            
            if !caption.isEmpty {
                Text("\(caption)")
                    .font(.caption)
            }
        }
    }
}

struct LookoutView: View {
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
            Image("LookoutBack").resizable().scaledToFill().ignoresSafeArea(.all)
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
                    Text("You are looking at: Left Direction")
                    .font(Font.custom("Krub-Regular", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white).frame(width: 247, height: 66)
                }
                HStack{
                    Spacer()
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
                    Spacer()
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
