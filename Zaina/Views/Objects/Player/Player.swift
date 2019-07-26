//
//  Player.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Player: Object {

  let imageView = UIImageView()

  var direction: Direction? = nil {
    didSet {
      if oldValue != direction {
        changeMovment()
      }
    }
  }

  var speed = 5
  var frames = Frames()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    addSubview(imageView)
  }

  private func changeMovment() {
    guard let direction = direction else {
      return
    }
    var movmentImages = [UIImage]()

    switch direction {
    case .left:
      movmentImages = frames.left!
    case .right:
      movmentImages = frames.right!
    case .top:
      movmentImages = frames.top!
    case .bottom:
      movmentImages = frames.bottom!
    case .center:
      movmentImages = frames.idel!
    case .topLeft:
      movmentImages = frames.topLeft ?? frames.left!
    case .bottomLeft:
      movmentImages = frames.bottomLeft ?? frames.left!
    case .topRight:
      movmentImages = frames.topRight ?? frames.right!
    case .bottomRight:
      movmentImages = frames.bottomRight ?? frames.right!
    }

    imageView.animationImages = movmentImages
    imageView.animationDuration = frames.duration
    imageView.startAnimating()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = bounds
  }

  func moveWith(x: CGFloat, y: CGFloat, direction: Direction?) {
    frame.origin.x += (5*x)
    frame.origin.y += (5*y)
    self.direction = direction ?? .center
  }
}
