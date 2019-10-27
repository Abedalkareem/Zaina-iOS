//
//  Analog.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

struct Analog {
  var direction: Direction
  var x: CGFloat
  var y: CGFloat
}

extension Analog: Equatable {
  static func ==(lhs: Analog, rhs: Analog) -> Bool {
      return lhs.direction == rhs.direction
  }
}


