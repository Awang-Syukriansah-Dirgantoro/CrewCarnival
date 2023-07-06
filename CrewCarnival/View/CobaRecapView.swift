////
////  CobaRecapView.swift
////  CrewCarnival
////
////  Created by Cliffton S on 27/06/23.
////
//
//import SwiftUI
//
//struct CobaRecapView: View {
//    @State private var showPopUp: Bool = false
//    var body: some View {
//        ZStack {
//            ZStack(alignment: .center) {
//                Image("back")
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)) {
//                        showPopUp.toggle()
//                    }
//                }, label: {
//                    Text("Show PopUp Window")
//                })
//                .padding()
//                .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
//            }
//            .foregroundColor(Color.white)
//            RecapSceneView(show: $showPopUp)
//        }.ignoresSafeArea()
//
//    }
//}
//
//
//struct CobaRecapView_Previews: PreviewProvider {
//    static var previews: some View {
//        CobaRecapView()
//    }
//}
//
