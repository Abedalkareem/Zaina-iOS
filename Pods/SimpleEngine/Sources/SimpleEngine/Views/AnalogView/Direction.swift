//
//  Direction.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//
import UIKit


/// direction value is from 0 to 1 as the `Direction` enum.
///
/// the value from 0 to 0.5 in case of x mean the direction is `left`.
/// the value from 0.5 to 1 in case of x mean the direction is `right`.
/// the value from 0 to 0.5 in case of x mean the direction is `top`.
/// the value from 0.5 to 1 in case of x mean the direction is `bottom`.
/// and the combination between the two of them give you `topRight`, `topLeft`,
/// `bottomRight` and `bottomLeft`.
/// if the two values is exatly 0.5, then the direction will be `center`.
public enum Direction {
  case topLeft
  case bottomLeft
  case topRight
  case bottomRight
  case left
  case right
  case top
  case bottom
  case center

  public init(x: CGFloat, y: CGFloat) {
    switch (x, y) {
    case (0.5, 0.5):
      self = .center
    case (0.6...1, 0...0.41):
      self = .topRight
    case (0...0.41, 0.59...1):
      self = .bottomLeft
    case (0.59...1, 0.59...1):
      self = .bottomRight
    case (0...0.41, 0...0.41):
      self = .topLeft
    case (0...0.5, 0.41...0.59):
      self = .left
    case (0.5...1, 0.41...0.59):
      self = .right
    case (0.41...0.59, 0...0.5):
      self = .top
    case (0.41...0.59, 0.5...1):
      self = .bottom
    default:
      self = .center
    }
  }
}
