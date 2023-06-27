//
//  ContentView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

struct AllRole: View {
    @State var currentTab = "role1"
    @State var roles = [
        Role(id: 0, image: "role1", description: "Lookout has the duty to monitor the surrounding conditions and provide information to the responsible authorities"),
        Role(id: 1, image: "role2", description: "Helmsman's duty is to drive the ship and pass through obstacles notified by the lookout"),
        Role(id: 2, image: "role3", description: "The sailing master's duty is to adjust the sails which affect the speed of the ship"),
        Role(id: 3, image: "role4", description: "Cabin boy is in charge of providing operational support and services on board"),
        Role(id: 4, image: "role5", description: "Blacksmith is in charge of making or repairing the necessary items"),
    ]
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                let size = proxy.size
                
                Image("backgroundhowtoplay").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height).cornerRadius(1)
            }.ignoresSafeArea()
            
            TabView(selection: $currentTab){
                ForEach(roles){role in
                    CarouselBodyView(roleimage: role.image, roledesc: role.description)
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
}

struct Role : Identifiable {
    var id: Int
    var image : String
    var description : String
}



struct AllRole_Previews: PreviewProvider {
    static var previews: some View {
       AllRole()
    }
}
