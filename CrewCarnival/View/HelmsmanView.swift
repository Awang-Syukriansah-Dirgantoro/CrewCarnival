//
//  HelmsmanView.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 21/06/23.
//

import SwiftUI

struct HelmsmanView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Image("BackgroundHelmsman")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    VStack{
                        Image("StearingWheel")
                            .resizable()
                            .frame(width: 300, height: 300)
                    }
                    Spacer()
                    VStack{
                        Text("Turn Progress")
                            .font(Font.custom("Krub-Regular", size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 108, height: 22)
                            .background(Color(.white))
                            .cornerRadius(15)
                        ProgressBar(progress: 30)
                    }
                }
            }
        }
    }
}

struct HelmsmanView_Previews: PreviewProvider {
    static var previews: some View {
        HelmsmanView()
    }
}
