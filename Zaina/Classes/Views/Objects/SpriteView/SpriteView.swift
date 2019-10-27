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

    var yDefrence: CGFloat = 1
    var xDefrence: CGFloat = 1

    let yme = y - frame.origin.y
    let xme = x - frame.origin.x
    if xme > yme {
      yDefrence = yme / xme
    } else {
      xDefrence = xme / yme
    }

    let movmentY: CGFloat = y > frame.origin.y ? 0.5 : -0.5
    let movmentX: CGFloat = x > frame.origin.x ? 0.5 : -0.5

    let directionY: CGFloat = y > frame.origin.y ? 1 : 0
    let directionX: CGFloat = x > frame.origin.x ? 1 : 0

    // convert the values from normal x and y to
    // a value from 0 to 1
    let x = x / (superview?.frame.width ?? 1)
    let y = y / (superview?.frame.height ?? 1)

    analog = Analog(direction: Direction(x: directionX, y: directionY), x: (movmentX * xDefrence), y: (movmentY * yDefrence))
    print(analog)
  }

  func moveXandYBy(x: CGFloat?, y: CGFloat?) {
    if let x = x, let y = y {
      frame.origin.x += (xSpeed*x)
      frame.origin.y += (ySpeed*y)
    }
  }

  func attachTo(_ analogView: AnalogView) {
    analogView.analogDidMove { [unowned self] (analog) in
      self.analog = analog
      print(analog)
    }
  }

  override func update() {
    if let desireX = desireX, let desireY = desireY {
      let xRange = desireX...(desireX + 2)
      let yRange = desireY...(desireY + 2)
      print("\(xRange) \(frame.origin.x) \(yRange) \(frame.origin.y) ")
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
