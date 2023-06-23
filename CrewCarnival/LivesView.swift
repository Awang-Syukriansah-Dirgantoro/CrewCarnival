//
//  ContentView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

struct LivesView: View {
    @State var lives = 2
    @State var isShowingRedScreen = false
    var body: some View {
        ZStack{
            
            Image("back").edgesIgnoringSafeArea(.all)
            if isShowingRedScreen{
                Color.red.edgesIgnoringSafeArea(.all).opacity(isShowingRedScreen ? 0.8 : 0.0).onAppear{
                    withAnimation(Animation.spring().speed(0.2)){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            isShowingRedScreen = false
                        }
                    }
                }
            }
            HStack {
                if lives == 3 {
                    Image("livesfill")
                    Image("livesfill")
                    Image("livesfill")
                }
                if lives == 2 {
                    Image("livesfill")
                    Image("livesfill")
                    Image("lives")
                }
                if lives == 1 {
                    Image("livesfill")
                    Image("lives")
                    Image("lives")
                }
                if lives == 0 {
                    Image("lives")
                    Image("lives")
                    Image("lives")
                }
            }
            .padding()
            
        }
        
    }
    
    func redFlash(){
        isShowingRedScreen = true
    }
}

struct LivesView_Previews: PreviewProvider {
    static var previews: some View {
        LivesView()
    }
}
