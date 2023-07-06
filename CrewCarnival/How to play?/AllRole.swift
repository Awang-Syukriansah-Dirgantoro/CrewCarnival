//
//  ContentView.swift
//  CrewCarnival
//
//  Created by Awang Syukriansah Dirgantoro on 20/06/23.
//

import SwiftUI

struct AllRole: View {
    @Binding var menu: Int
    @State var currentTab = "role1"
    @State var roles = [
        Roles(id: 0, image: "role1", description: "Lookout has the duty to monitor the surrounding conditions and provide information to the responsible authorities"),
        Roles(id: 1, image: "role2", description: "Helmsman's duty is to drive the ship and pass through obstacles notified by the lookout"),
        Roles(id: 2, image: "role3", description: "The sailing master's duty is to adjust the sails which affect the speed of the ship"),
        Roles(id: 3, image: "role4", description: "Cabin boy is in charge of providing operational support and services on board"),
        Roles(id: 4, image: "role5", description: "Blacksmith is in charge of making or repairing the necessary items"),
    ]
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    Image("backgroundhowtoplay").resizable().aspectRatio(contentMode: .fill).frame(width: size.width+1, height: size.height)
                }.ignoresSafeArea()
                
                Text("Swipe to see another roles").offset(y: -290).foregroundColor(.white)
                
                TabView(selection: $currentTab){
                    ForEach(roles){role in
                        CarouselBodyView(roleimage: role.image, roledesc: role.description)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            menu = -1
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct Roles : Identifiable {
    var id: Int
    var image : String
    var description : String
}



struct AllRole_Previews: PreviewProvider {
    static var previews: some View {
       AllRole(menu: .constant(0)).environmentObject(GameService())
    }
}
