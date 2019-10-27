//
//  AnalogView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/22/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

/// An Analog controller to control the `Sprite` movement.
@IBDesignable
class AnalogView: UIView {

  typealias AnalogMoved = ((Analog) -> Void)

  // MARK: - Properties

  @IBInspectable var analogImage: UIImage = UIImage() {
    didSet {
      analogImageView.image = analogImage
    }
  }
  @IBInspectable var backgroundImage: UIImage = UIImage() {
     didSet {
       backgroundImageView.image = backgroundImage
     }
   }

  // MARK: Private properties

  private let backgroundImageView = UIImageView()
  private let analogImageView = UIImageView()

  private var analog: Analog = Analog(direction: .center, x: 0, y: 0) {
    didSet {
      analogMoved?(analog)
    }
  }

  private var analogMoved: AnalogMoved?

  // MARK: - init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {

    backgroundColor = .clear

    analogImageView.image = analogImage
    backgroundImageView.image = backgroundImage

    addSubview(backgroundImageView)
    addSubview(analogImageView)
  }

  // MARK: - View lifecycle

  override func layoutSubviews() {
    super.layoutSubviews()
    analogImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    analogImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)

    backgroundImageView.frame = bounds
  }

  // MARK: - Touches

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if let point = touches.first?.location(in: self) {
      moveTo(point: point)
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    if let point = touches.first?.location(in: self) {
      moveTo(point: point)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    // animate the analog back to center
    UIView.animate(withDuration: 0.3) {
      self.moveTo(point: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
    }
  }

  private func moveTo(point: CGPoint) {

    let validX = point.x > 0 && point.x < frame.width
    let validY = point.y > 0 && point.y < frame.height

    if validY {
      analogImageView.center.y = point.y
    }
    if validX {
      analogImageView.center.x = point.x
    }

    // convert the values from normal width and height to
    // a value from 0 to 1
    var x = point.x / frame.width
    var y = point.y / frame.height

    // if x and y values less than 0 then set the value to 0
    x = x < 0 ? 0 : x
    y = y < 0 ? 0 : y

    // if x and y values more than 1 then set the value to 1
    x = x > 1 ? 1 : x
    y = y > 1 ? 1 : y

    // get the direction of the analog depending on the x and y
    let direction = Direction(x: x, y: y)

    // convert the values from 0 to 1, to -0.5 to 0.5,
    // so you can use this value to move the `Sprite` from left to
    // right with a speed depending on how much the user is pushing the
    // analog.
    // The value in negative means that the analog is
    // going left in case of x and top in case of y,
    // while the value in positive means that the user move to
    // right in case of y or bottom in case of x.
    x = x - 0.5
    y = y - 0.5

    analog = Analog(direction: direction, x: x, y: y)

  }

  // MARK: - Public methods

  public func analogDidMove(analogMoved: @escaping AnalogMoved) {
    self.analogMoved = analogMoved
  }
}
