//
//  ProgressBar.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.88, green: 0.68, blue: 0)]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        let gradientStyle = GradientProgressStyle(
            stroke: .clear,
            fill: gradient,
            caption: ""
        )
        HStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 15)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(13)
                    .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(Color(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 5))
                    .padding(.horizontal, 20)
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 100, height: 15)
//                    .background(Color(red: 0.88, green: 0.68, blue: 0))
//                    .cornerRadius(13)
//                    .padding(.horizontal, 20)
                ProgressView("", value: progress, total: 100)
                    .padding(.horizontal, 20)
                    .progressViewStyle(gradientStyle)
                Image("ImageProgressBar")
                    .resizable()
                    .frame(width: 45, height: 45)
            }
            .padding(.horizontal, 20)
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 10)
    }
}
