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

  var backgroundAudioPlayer: AVAudioPlayer?
  var subAudioPlayer: AVAudioPlayer?
  var isPlaying = false

  init() {

  }

  func playBackgroundMusicWith(music: Music) {
    let path = Bundle.main.path(forResource: music.rawValue, ofType: music.type.rawValue)!
    let url = URL(fileURLWithPath: path)
    do {
      backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
      backgroundAudioPlayer?.numberOfLoops = 10
      backgroundAudioPlayer?.volume = 0.4
    } catch {
      print(error.localizedDescription)
    }
    backgroundAudioPlayer?.play()
    isPlaying = true
  }

  func pauseBackgroundMusic() {
    backgroundAudioPlayer?.pause()
    isPlaying = false
  }

  func playMusic(music: Music) {
    guard let path = Bundle.main.path(forResource: music.rawValue, ofType: music.type.rawValue) else {
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

  var type: Type {
    switch self {
    case .background:
      return .wav
    case .mainScreen:
      return .mp3
    case .darkForest:
      return .mp3
    case .gameOver:
      return .wav
    case .piano90e:
      return .mp3
    case .cooking:
      return .wav
    case .about:
      return .wav
    case .youWin:
      return .wav
    case .finalFight:
      return .mp3
    }
  }

  case background
  case mainScreen = "main_screen"
  case darkForest = "darkforest"
  case gameOver = "game_over"
  case cooking = "fire"
  case piano90e
  case about
  case youWin = "you_win"
  case finalFight = "final_fight"
}

enum Type: String {
  case mp3
  case wav
}
