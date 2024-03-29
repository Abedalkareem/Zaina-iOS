//
//  SimpleMusicPlayer.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/31/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import AVFoundation
import UIKit

open class SimpleMusicPlayer: NSObject {

  ///
  /// A singleton object to use the music player.
  ///
  public static let shared = SimpleMusicPlayer()

  // MARK: - Properties

  ///
  /// To check if the background audio is playing or not.
  ///
  open var isPlaying = false

  ///
  /// Volume of the background audio.
  /// The default is `0.5`.
  ///
  open var backgroundAudioPlayerVolume: Float = 0.5

  ///
  /// Volume of the sub audio.
  /// The default is `1`.
  ///
  open var subAudioPlayerVolume: Float = 1.0

  // MARK: - Private properties

  ///
  /// An ongoing audio playing in the background.
  ///
  private var backgroundAudioPlayer: AVAudioPlayer?

  ///
  /// A audio to play one time.
  ///
  private var subAudioPlayers = [(name: String, player: AVAudioPlayer)]()

  private var cachedMusic = [String: AVAudioPlayer]()

  ///
  /// Start playing the background music forever.
  ///
  open func playBackgroundMusicWith<M: MusicType>(music: M) {
    guard let path = Bundle.main.path(forResource: music.rawValue, ofType: music.format) else {
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
      backgroundAudioPlayer?.numberOfLoops = .max
      backgroundAudioPlayer?.volume = backgroundAudioPlayerVolume
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
  open func playMusic<M: MusicType>(music: M, shouldBeCached: Bool = false) {
    if let music = cachedMusic[music.rawValue], shouldBeCached {
      music.play()
      return
    }
    guard let path = Bundle.main.path(forResource: music.rawValue, ofType: music.format) else {
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      let subAudioPlayer = try AVAudioPlayer(contentsOf: url)
      subAudioPlayer.volume = subAudioPlayerVolume
      subAudioPlayer.play()
      subAudioPlayer.delegate = self
      if shouldBeCached {
        cachedMusic[music.rawValue] = subAudioPlayer
      }
      self.subAudioPlayers.append((music.rawValue, subAudioPlayer))
    } catch {
      print(error.localizedDescription)
    }
  }

  open func stopMusic<M: MusicType>(music: M) {
    let audio = subAudioPlayers.first { $0.name == music.rawValue }
    audio?.player.stop()
    subAudioPlayers.removeAll { $0.name == music.rawValue }
  }
}

public protocol MusicType: RawRepresentable where RawValue == String {
  var format: String { get }
}

extension SimpleMusicPlayer: AVAudioPlayerDelegate {
  public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    DispatchQueue(label: "app.virus.audio").async { [weak self] in
      guard let index = self?.subAudioPlayers.firstIndex(where: { $0.player == player }) else {
        return
      }
      self?.subAudioPlayers.remove(at: index)
    }
  }
}
