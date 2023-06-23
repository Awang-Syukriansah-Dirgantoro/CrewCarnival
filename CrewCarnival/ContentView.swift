//
//  ContentView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

struct ContentView: View {
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
                    Text("❤️")
                    Text("❤️")
                    Text("❤️")
                }else if lives == 2{
                    Text("❤️")
                    Text("❤️")
                    Text("🤍")
                }else if lives == 1{
                    Text("❤️")
                    Text("🤍")
                    Text("🤍")
                }else{
                    Text("🤍")
                    Text("🤍")
                    Text("🤍")
                }
                Button("gas"){
                    redFlash()
                }
            }
            .padding()
            
        }
        
    }
    
    func redFlash(){
        isShowingRedScreen = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
