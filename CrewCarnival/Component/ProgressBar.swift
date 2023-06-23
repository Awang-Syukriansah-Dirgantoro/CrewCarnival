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
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 15)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .cornerRadius(13)
                    .background(RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(Color(red: 0.5, green: 0.5, blue: 0.5), lineWidth: 5))
                    .padding(.horizontal, 20)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: progress, height: 15)
                    .background(Color(red: 0.88, green: 0.68, blue: 0))
                    .cornerRadius(13)
                Image("ImageProgressBar")
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

