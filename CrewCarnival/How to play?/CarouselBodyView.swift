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
    var roledesc: String
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            ZStack{
                Image("\(roleimage)").resizable().frame(width: size.width - 20, height: size.height / 1.6).cornerRadius(12).foregroundColor(.white).opacity(0.8)
                VStack{
                    VStack(spacing: 25){
                        VStack(alignment: .center){
                            Text("\(roledesc)").kerning(1.2).foregroundStyle(.black) .multilineTextAlignment(.center).font(.system(size: 14))
                        }.foregroundColor(.black).offset(y: 100)
                    }.padding(20).frame(width: size.width - 130)
                }.padding(20)
            }.frame(width: size.width - 20, height: size.height / 1.6).frame(width: size.width, height: size.height)
        }.tag("\(roleimage)")
            .rotation3DEffect(.init(degrees: getProgress() * 90), axis: (x: 0, y: 1, z: 0), anchor: offset > 0 ? .leading:.trailing, anchorZ: 0, perspective: 0.6)
            .modifier(ScrollViewOffsetModifier(anchorPoint: .leading, offset: $offset))
    }
    func getProgress()->CGFloat{
        let progress = -offset / (UIScreen.main.bounds.width)
        return progress
    }
}


