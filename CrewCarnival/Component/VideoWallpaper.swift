//
//  VideoWallpaper.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 07/07/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable{
//    var listView = ["Lookout1","Lookout2","Lookout3"]
//    private var views = ""
//    @EnvironmentObject var gameService: GameService
    @Binding var look:String
    
//    init(look: String) {
//        self.views = look
//        print("lookName: \(look)")
////        for (_, player) in gameService.party.players.enumerated() {
////            if player.role == Role.lookout {
////                if player.event.objective == Objective.lookLeft {
////                    self.views = "Lookout2"
////                } else if player.event.objective == Objective.lookRight {
////                    self.views = "Lookout3"
////                } else {
////                    self.views = "Lookout1"
////                }
////            }
////        }
//    }
    
    func updateUIView(_ uiView: LoopingPlayerUIView, context: UIViewRepresentableContext<PlayerView>) {
//        uiView = LoopingPlayerUIView(videoName: look)
        uiView.updateVideo(videoName: look)
//        print("Look Update",look)
    }

    func makeUIView(context: Context) -> LoopingPlayerUIView {
//        print("videoName: \(views)")
//        print("Look", look)
        return LoopingPlayerUIView(videoName: look)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(videoName: String,
         videoGravity: AVLayerVideoGravity = .resizeAspectFill) {
        
        super.init(frame: .zero)
        
        let fileUrl = Bundle.main.url(forResource: videoName, withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        
        player.isMuted = true // just in case
        playerLayer.player = player
        playerLayer.videoGravity = videoGravity
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        player.play()
    }
    
    func updateVideo(videoName: String,
                     videoGravity: AVLayerVideoGravity = .resizeAspectFill){
//        print("Video Name",videoName)
        
        layer.sublayers?.removeAll()
        let fileUrl = Bundle.main.url(forResource: videoName, withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        let player = AVQueuePlayer()
        
        player.isMuted = true // just in case
        playerLayer.player = player
        playerLayer.videoGravity = videoGravity
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        
        player.play()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
