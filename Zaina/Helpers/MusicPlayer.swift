//
//  MusciPlayer.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/31/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayer {

  static let shared = MusicPlayer()

  var audioPlayer: AVAudioPlayer?
  var subAudioPlayer: AVAudioPlayer?
  var isPlaying = false

  init() {
    let path = Bundle.main.path(forResource: Music.background.rawValue, ofType: Type.wav.rawValue)!
    let url = URL(fileURLWithPath: path)

    do {
      audioPlayer = try AVAudioPlayer(contentsOf: url)
      audioPlayer?.numberOfLoops = 10
      audioPlayer?.volume = 0.4
    } catch {
      print(error.localizedDescription)
    }
  }

  func play() {
    audioPlayer?.play()
    isPlaying = true
  }

  func pause() {
    audioPlayer?.pause()
    isPlaying = false
  }

  func playMusic(music: Music, type: Type) {
    guard let path = Bundle.main.path(forResource: music.rawValue, ofType: type.rawValue) else {
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      subAudioPlayer = try AVAudioPlayer(contentsOf: url)
      subAudioPlayer?.play()
    } catch {
      print(error.localizedDescription)
    }
  }
}

enum Music: String {
  case background
}

enum Type: String {
  case mp3
  case wav
}
