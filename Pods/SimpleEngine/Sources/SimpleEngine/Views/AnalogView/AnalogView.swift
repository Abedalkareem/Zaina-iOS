//
//  AnalogView.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/22/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

/// An Analog controller to control the `Sprite` movement.
@IBDesignable
open class AnalogView: UIView {

  public typealias AnalogMoved = ((Analog) -> Void)

  // MARK: - IBInspectables

  @IBInspectable open var analogImage: UIImage = UIImage() {
    didSet {
      analogImageView.image = analogImage
    }
  }

  @IBInspectable open var backgroundImage: UIImage = UIImage() {
     didSet {
       backgroundImageView.image = backgroundImage
     }
   }

  // MARK: - Properties

  open var analog: Analog = Analog(direction: .center, x: 0, y: 0) {
    didSet {
      analogMoved?(analog)
    }
  }

  // MARK: Private properties

  private let backgroundImageView = UIImageView()
  private let analogImageView = UIImageView()
  private var analogMoved: AnalogMoved?

  // MARK: - init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupViews()
  }

  private func setupViews() {

    backgroundColor = .clear

    if let analogImage = Settings.analogImage {
      analogImageView.image = analogImage
    } else {
      analogImageView.image = analogImage
    }
    if let backgroundImage = Settings.backgroundImage {
      backgroundImageView.image = backgroundImage
    } else {
      backgroundImageView.image = backgroundImage
    }
    alpha = Settings.alpha

    addSubview(backgroundImageView)
    addSubview(analogImageView)
  }

  // MARK: - View lifecycle

  override open func layoutSubviews() {
    super.layoutSubviews()
    analogImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    analogImageView.center = CGPoint(x: bounds.midX, y: bounds.midY)

    backgroundImageView.frame = bounds
  }

  // MARK: - Touches

  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if let point = touches.first?.location(in: self) {
      moveTo(point: point)
    }
  }

  override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    if let point = touches.first?.location(in: self) {
      moveTo(point: point)
    }
  }

  override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    // animate the analog back to center
    UIView.animate(withDuration: 0.3) {
      self.moveTo(point: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
    }
  }

  override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
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

  open func analogDidMove(analogMoved: @escaping AnalogMoved) {
    self.analogMoved = analogMoved
  }

  public enum Settings {
    ///
    /// A shared analog image for all analogs in the porject.
    ///
    public static var analogImage: UIImage?
    ///
    /// A shared analog background image for all analogs in the porject.
    ///
    public static var backgroundImage: UIImage?
    ///
    /// Analog alpha. The default is `0.5`.
    ///
    public static var alpha: CGFloat = 0.5
    ///
    /// Analog size. The default is `150`.
    ///
    public static var analogSize: CGFloat = 140
    ///
    /// Analog margen. The default is `0.5`.
    ///
    public static var margen: CGFloat = 15
  }
}
