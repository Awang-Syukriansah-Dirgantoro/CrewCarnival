//
//  ProgressBar.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 23/06/23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 30)
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 273.50601, height: 15)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(13)
                    .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(Color(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 5))
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: progress, height: 15)
                    .background(Color(red: 0.88, green: 0.68, blue: 0))
                    .cornerRadius(13)
                
                Image("ImageProgressBar")
                    .background(Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 50, height: 50)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .cornerRadius(42)).offset(x: -40)
            }
        }
        
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 10)
    }
}

