//
//  Analog.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

public struct Analog {
  public var direction: Direction
  public var x: CGFloat
  public var y: CGFloat
}

extension Analog: Equatable {
  public static func == (lhs: Analog, rhs: Analog) -> Bool {
    lhs.direction == rhs.direction
  }
}
