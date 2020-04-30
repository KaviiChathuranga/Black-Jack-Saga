//
//  MusicExtention.swift
//  Black Jack Saga
//
//  Created by Treinetic Macbook004 on 8/21/19.
//  Copyright © 2019 Treinetic Macbook004. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class MusicExtention{
    
}
extension StandAndHitViewController{
    static func adjustMusic(Volume vol : Float){
        guard let audioPlayer = StandAndHitViewControllerStruct.backgroundAudioPlayer else { return }
        audioPlayer.volume = vol
    }
    
    //    func stopMusic() {
    //        guard let audioPlayer = StandAndHitViewControllerStruct.backgroundAudioPlayer else { return }
    //        StandAndHitViewControllerStruct.backgroundAudioPlayer.stop()
    //    }
    
    // play sound effects
    func playSound(type : String){
        if structure.audioFilePath != nil && structure.winFilePath != nil{
            if type == "shuffle"{
                let audioFileUrl = NSURL.fileURL(withPath: structure.audioFilePath!)
                structure.audioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
                StandAndHitViewController.adjustMusic(Volume: 0.5)
            }
            if type == "win"{
                let audioFileUrl = NSURL.fileURL(withPath: structure.winFilePath!)
                structure.audioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
                StandAndHitViewController.adjustMusic(Volume: 0.5)
            }
            if type == "lost"{
                let audioFileUrl = NSURL.fileURL(withPath: structure.lostFilePath!)
                structure.audioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
                StandAndHitViewController.adjustMusic(Volume: 0.5)
            }
            if type == "draw"{
                let audioFileUrl = NSURL.fileURL(withPath: structure.drawFilePath!)
                structure.audioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
                StandAndHitViewController.adjustMusic(Volume: 0.5)
            }
            if type == "main" && StandAndHitViewControllerStruct.backgroundMusic != nil {
                
                let audioFileUrl = NSURL.fileURL(withPath: StandAndHitViewControllerStruct.backgroundMusic!)
                StandAndHitViewControllerStruct.backgroundAudioPlayer = try?AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
            }
        } else {
            print("audio file is not found")
        }
        
        if StandAndHitViewControllerStruct.backgroundMusic != nil {
            StandAndHitViewController.adjustMusic(Volume: 1)
            StandAndHitViewControllerStruct.backgroundAudioPlayer.play()
        }
        
        if structure.audioFilePath != nil && type != "main"{
            StandAndHitViewController.adjustMusic(Volume: 0.5)
            structure.audioPlayer.play()
        }
    }
}
