//
//  VideoWallpaper.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 07/07/23.
//

import SwiftUI
import AVKit
import AVFoundation


struct PlayerView: UIViewRepresentable {
    private var listView = ["Lookout1","Lookout2","Lookout3"]
    private var views = ""
    
    
    init() {
        self.views = listView.randomElement()!
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) { }

    func makeUIView(context: Context) -> UIView {
        print("videoName: \(views)")
        return LoopingPlayerUIView(videoName: views)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
