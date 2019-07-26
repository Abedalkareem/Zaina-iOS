//
//  Controller.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/22/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Controller: UIView {

  typealias AnalogMoved = ((Analog) -> Void)

  private let backgroundImageView = UIImageView()
  private let analogImageView = UIImageView()

  var analog: Analog = Analog(direction: .center, x: 0, y: 0) {
    didSet {
      analogMoved?(analog)
    }
  }

  var analogMoved: AnalogMoved?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {
    analogImageView.image = #imageLiteral(resourceName: "controller_analog")
    backgroundImageView.image = #imageLiteral(resourceName: "controller_background")
    addSubview(backgroundImageView)
    addSubview(analogImageView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    analogImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    analogImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)

    backgroundImageView.frame = bounds
  }

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

    var x = point.x / frame.width
    var y = point.y / frame.height

    x = x < 0 ? 0 : x
    y = y < 0 ? 0 : y

    x = x > 1 ? 1 : x
    y = y > 1 ? 1 : y

    let direction = Direction(x: x, y: y)

    x = x - 0.5
    y = y - 0.5

    analog = Analog(direction: direction, x: x, y: y)

  }

  public func analogDidMove(analogMoved: @escaping AnalogMoved) {
    self.analogMoved = analogMoved
  }
}
