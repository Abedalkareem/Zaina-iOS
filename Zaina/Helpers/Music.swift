//
//  Music.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

enum Music: String, MusicType {
  var format: String {
    var type: Type!
    switch self {
    case .background:
      type = .wav
    case .mainScreen:
      type = .mp3
    case .darkForest:
      type = .mp3
    case .gameOver:
      type = .wav
    case .piano90e:
      type = .mp3
    case .cooking:
      type = .wav
    case .about:
      type = .wav
    case .youWin:
      type = .wav
    case .finalFight:
      type = .mp3
    }

    return type.rawValue
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
