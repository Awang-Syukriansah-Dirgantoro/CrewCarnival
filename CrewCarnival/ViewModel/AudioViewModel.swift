//
//  AudioViewModel.swift
//  CrewCarnival
//
//  Created by Aiffah Kiysa Waafi on 28/06/23.
//

import SwiftUI
import AVKit

class AudioViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static var shared = AudioViewModel()
    var audioPlayer: AVAudioPlayer!
    
    func playSound(url: String){
//        let resourcePath = Bundle.main.path(forResource: url, ofType: "mp3")
//        do{
//            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: resourcePath!))
//            print(url)
//            if let audioPlayer = audioPlayer{
//                audioPlayer.play()
//            }
//        }
//        catch{
//            print(error.localizedDescription)
//        }
    }
    
    func stopSound(url: String){
        let resourcePath = Bundle.main.path(forResource: url, ofType: "mp3")
        
        do{
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: resourcePath!))
            
            audioPlayer.stop()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
