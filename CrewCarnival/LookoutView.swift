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
    var height: CGFloat = 20
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
        gradient: Gradient(colors: [.yellow, .green]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .black,
            fill: gradient,
            caption: ""
        )
        ZStack{
            Image("back").resizable().scaledToFill().ignoresSafeArea(.all)
            VStack{
                HStack{
                    Text("Lookout")
                    Spacer()
                    HStack {
                        Text("❤️")
                        Text("❤️")
                        Text("❤️")
                    }
                }.padding(.bottom).padding(.horizontal,30)
                ProgressView("", value: downloadAmount, total: 100).progressViewStyle(gradientStyle).padding(.bottom,20).padding(.horizontal,30)
                ZStack{
                    Rectangle().frame(height: 60).opacity(0.5)
                    Text("There are obstacles nearby!")
                    .font(Font.custom("", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.95, green: 0.74, blue: 0))
                }
            }
        }
    }
}

struct LookoutView_Previews: PreviewProvider {
    static var previews: some View {
        LookoutView()
    }
}
