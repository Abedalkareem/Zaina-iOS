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

  ///
  /// A singleton object to use the music player.
  ///
  static let shared = MusicPlayer()

  // MARK: - Properties

  ///
  /// To check if the background audio is playing or not.
  ///
  var isPlaying = false

  // MARK: - Private properties

  ///
  /// An ongoing audio playing in the background.
  ///
  private var backgroundAudioPlayer: AVAudioPlayer?

  ///
  /// A audio to play one time.
  ///
  private var subAudioPlayer: AVAudioPlayer?

  ///
  /// Start playing the background music for ever.
  ///
  func playBackgroundMusicWith(music: Music) {
    let path = Bundle.main.path(forResource: music.rawValue, ofType: music.type.rawValue)!
    let url = URL(fileURLWithPath: path)
    do {
      backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
      backgroundAudioPlayer?.numberOfLoops = .max
      backgroundAudioPlayer?.volume = 0.4
    } catch {
      print(error.localizedDescription)
    }
    backgroundAudioPlayer?.play()
    isPlaying = true
  }

  ///
  /// Pause background music.
  ///
  func pauseBackgroundMusic() {
    backgroundAudioPlayer?.pause()
    isPlaying = false
  }

  ///
  /// Play a music one time.
  ///
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
