//
//  Sprite.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Sprite: Object {

  let imageView = UIImageView()

  var direction: Direction? = nil {
    didSet {
      if oldValue != direction {
        changeMovment()
      }
    }
  }

  var speed: CGFloat = 5 {
    didSet {
      xSpeed = speed
      ySpeed = speed
    }
  }
  var frames = Frames()
  var stopWhenCollideTyps = [Int]()

  private var xSpeed: CGFloat = 5
  private var ySpeed: CGFloat = 5

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

  override func onCollisionEnter(with object: Object?) {
    guard let object = object, stopWhenCollideTyps.contains(object.type) else {
      xSpeed = speed
      ySpeed = speed
      return
    }

    let x = frame.origin.x
    let y = frame.origin.y
    let objectX = object.frame.origin.x
    let objectY = object.frame.origin.x

    frame.origin.x += (x > objectX ? (speed * 0.5) : (speed * -0.5))
    frame.origin.y += (y > objectY ? (speed * -0.5) : (speed * 0.5))

  }

  func moveWith(x: CGFloat, y: CGFloat, direction: Direction?) {
    frame.origin.x += (xSpeed*x)
    frame.origin.y += (ySpeed*y)
    self.direction = direction ?? .center
  }
}
