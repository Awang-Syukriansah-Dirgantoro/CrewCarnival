//
//  PartyFrontEndView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 27/06/23.
//

import SwiftUI

struct PartyFrontEndView: View {
    var body: some View {
        ZStack{
            Image("backgroundroom").ignoresSafeArea()
            Text("Waiting For \n Players").font(.custom("Gasoek One", size: 30)).foregroundColor(.white).offset(y: -200).multilineTextAlignment(.center).shadow(color: .yellow, radius: 1)
            HStack(spacing: 0){
                Image("Helmsman")
                Image("Lookout")
                Image("SailMaster").offset(y:-8)
                Image("Blacksmith").offset(y:-8)
                Image("CabinBoy")
            }.offset(y: 50)
            HStack(spacing: 30){
                Image("tickbtn")
                Image("tickbtn")
                Image("tickbtn")
                Image("tickbtn")
                Image("tickbtn")
            }.offset(y: 200)
            Image("readybtn").offset(y: 320)
            
        }
    }
}

struct PartyFrontEndView_Previews: PreviewProvider {
    static var previews: some View {
        PartyFrontEndView()
    }
}
