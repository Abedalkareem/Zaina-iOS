//
//  SpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

@IBDesignable
class SpriteView: ObjectView {

  @IBInspectable var speed: CGFloat = 5 {
    didSet {
      xSpeed = speed
      ySpeed = speed
    }
  }

  @IBInspectable var initialImage: UIImage = UIImage() {
    didSet {
      backgroundColor = .clear
      imageView.image = initialImage
    }
  }

  var frames = Frames()
  var stopWhenCollideTyps = [Int]()

  private var xSpeed: CGFloat = 5
  private var ySpeed: CGFloat = 5

  private var desireX: CGFloat?
  private var desireY: CGFloat?

  private var analog: Analog? {
    didSet {
      if oldValue != analog {
        changeMovment()
      }
    }
  }

  private let imageView = UIImageView()

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
    guard let direction = analog?.direction else {
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

  override func onCollisionEnter(with object: ObjectView?) {
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

  func moveTo(x: CGFloat, y: CGFloat) {
    desireX = x
    desireY = y

    // get the defrence between the x and y,
    // so if the x equal to 100, and the y equal to 50,
    // the y should be the half of the x movement percentage.
    let yWithoutTheStartPoint = abs(y - frame.origin.y)
    let xWithoutTheStartPoint = abs(x - frame.origin.x)
    var yDefrence: CGFloat = 1
    var xDefrence: CGFloat = 1
    if xWithoutTheStartPoint > yWithoutTheStartPoint {
      yDefrence = yWithoutTheStartPoint / xWithoutTheStartPoint
    } else {
      xDefrence = xWithoutTheStartPoint / yWithoutTheStartPoint
    }

    // to get the movment percentage, so in case of x, 0.5 move to right, -0.5 move to left.
    // and in case of y, 0.5 move to bottom, -0.5 move to top.
    let yMovementPercentage: CGFloat = y > frame.origin.y ? 0.5 : -0.5
    let xMovementPercentage: CGFloat = x > frame.origin.x ? 0.5 : -0.5

    // direction value is from 0 to 1 as the `Direction` enum.
    // check `Direction` enum.
    let directionY: CGFloat = y > frame.origin.y ? 1 : 0
    let directionX: CGFloat = x > frame.origin.x ? 1 : 0

    let newX = (xMovementPercentage * xDefrence)
    let newY = (yMovementPercentage * yDefrence)

    analog = Analog(direction: Direction(x: directionX, y: directionY), x: newX, y: newY)
    print(analog)
  }

  func moveXandYBy(x: CGFloat?, y: CGFloat?) {
    if let x = x, let y = y {
      frame.origin.x += (xSpeed * x)
      frame.origin.y += (ySpeed * y)
    }
  }

  func attachTo(_ analogView: AnalogView) {
    analogView.analogDidMove { [unowned self] (analog) in
      self.analog = analog
    }
  }

  override func update() {
    if let desireX = desireX, let desireY = desireY {
      let xRange = (desireX - 5)...(desireX + 5)
      let yRange = (desireY - 5)...(desireY + 5)
      if xRange.contains(frame.origin.x) && yRange.contains(frame.origin.y) {
        self.desireX = nil
        self.desireY = nil
        self.analog = Analog(direction: .center, x: 0, y: 0)
        return
      }
    }
    moveXandYBy(x: analog?.x, y: analog?.y)
  }

}
