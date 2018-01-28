//
//  Audioplayer.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

enum AudioPlayerState {
    case Idle
    case Playing
    case Paused
    case DidEnd
}

class AudioPlayer: NSObject, AVAudioPlayerDelegate {

    var player: AVAudioPlayer!
    var playerDidPLay: Bool = false
    var playButtonImage: UIImage = #imageLiteral(resourceName: "eggZachtMedium")

    // closure to update UI in VC that uses player
    var audioFragmentDidFinish: ((Bool) -> Void)?

    func playSound(file: String, ext: String, playForever: Bool) {

        guard let file: URL = Bundle.main.url(forResource: file, withExtension: ext) else {
            print("error")
            return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: file)

            guard let player = player else { return }
            if playForever {
                player.numberOfLoops = -1
            } else {
                player.numberOfLoops = 0
            }
            playButtonImage = #imageLiteral(resourceName: "eggZachtMedium")
            player.delegate = self

            player.play()
            playerDidPLay = true
        } catch {
            print("The audio file does not exist")
            return
        }
    }
    func resumePlaying() {
        if player != nil && playerDidPLay {
            playButtonImage = #imageLiteral(resourceName: "eggZacht")
            player.play()
        }
    }

    func stopPlaying() {
        if player != nil {
            player.stop()
            player = nil
        }
    }

    func pausePlaying() {
        if playerDidPLay {
            playButtonImage = #imageLiteral(resourceName: "eggMedium")
            player.pause()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playButtonImage = #imageLiteral(resourceName: "eggMediumHard")
        audioFragmentDidFinish?(true)
    }
}

