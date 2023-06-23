//
//  CarouselBodyView.swift
//  CrewCarnival
//
//  Created by Cliffton S on 23/06/23.
//

import SwiftUI

struct CarouselBodyView: View {
    @State var offset: CGFloat = 0
    var roleimage: String
    var roletitle: String
    var roledesc: String
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            ZStack{
                Rectangle().frame(width: size.width - 20, height: size.height / 1.3).cornerRadius(12).foregroundColor(.white).opacity(0.8)
                VStack{
                    Image("\(roleimage)").resizable().frame(width: 180,height: 320)
                    VStack(spacing: 25){
                        VStack(alignment: .center, spacing: 6){
                            Text("\(roletitle)").font(.title2.bold()).kerning(1.5)
                            
                            Text("\(roledesc)").kerning(1.2).foregroundStyle(.secondary)
                        }.foregroundColor(.black)
                    }.padding(20).background(.white)
                }.padding(20)
            }.frame(width: size.width - 20, height: size.height / 1.3).frame(width: size.width, height: size.height)
        }.tag("\(roleimage)")
            .rotation3DEffect(.init(degrees: getProgress() * 90), axis: (x: 0, y: 1, z: 0), anchor: offset > 0 ? .leading:.trailing, anchorZ: 0, perspective: 0.6)
            .modifier(ScrollViewOffsetModifier(anchorPoint: .leading, offset: $offset))
    }
    func getProgress()->CGFloat{
        let progress = -offset / (UIScreen.main.bounds.width)
        return progress
    }
}

struct CarouselBodyView_Previews: PreviewProvider {
    static var previews: some View {
       AllRole()
    }
}

