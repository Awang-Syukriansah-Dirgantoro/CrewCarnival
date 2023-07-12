//
//  HowtoplayView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 11/07/23.
//

import SwiftUI

struct HowtoplayView: View {
    @Binding var menu: Int
    var body: some View {
        NavigationStack {
            ZStack{
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    Image("HowtoPlay").resizable().aspectRatio(contentMode: .fill).frame(width: size.width, height: size.height)
                }.ignoresSafeArea()
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)).toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        menu = -1
                    } label: {
                        Image("BackButton")
                    }
                }
            }
        }
    }
}

struct HowtoplayView_Previews: PreviewProvider {
    static var previews: some View {
        HowtoplayView(menu: .constant(0)).environmentObject(GameService())
    }
}
