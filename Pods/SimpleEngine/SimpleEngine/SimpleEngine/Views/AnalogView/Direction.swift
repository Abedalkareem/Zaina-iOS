//
//  Direction.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//
import UIKit

/// Direction value is a value between 0 to 1 that mapped to a `Direction`.
///
/// The value from 0 to 0.5 in case of x mean the direction is `left`.
/// The value from 0.5 to 1 in case of x mean the direction is `right`.
/// The value from 0 to 0.5 in case of y mean the direction is `top`.
/// The value from 0.5 to 1 in case of y mean the direction is `bottom`.
/// The combination between the two of them give you `topRight`, `topLeft`,
/// `bottomRight` and `bottomLeft`.
/// If the two values are exatly 0.5, then the direction will be `center`.
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
