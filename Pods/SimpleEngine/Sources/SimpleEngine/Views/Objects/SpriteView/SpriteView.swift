//
//  SpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

@IBDesignable
open class SpriteView: ObjectView {

  // MARK: - IBInspectables

  ///
  /// The speed of the sprite is how many pixels it will move per frame. The defualt value is `5`.
  ///
  @IBInspectable open var speed: CGFloat = 5 {
    didSet {
      xSpeed = speed
      ySpeed = speed
    }
  }

  ///
  /// The first image it will show when you add the sprite to the storyboard. after that it will show the `Freams`.
  ///
  @IBInspectable open var initialImage: UIImage = UIImage() {
    didSet {
      backgroundColor = .clear
      imageView.image = initialImage
    }
  }

  // MARK: - Properties

  ///
  /// You can set the images (frames) that will show when the user move to right, left,
  /// top, bottom, topLeft, bottomLeft, topRight, bottomRight or idel.
  ///
  open var frames = Frames()

  ///
  /// The ` SpriteView` will stop when it collide with one of this types.
  /// Like if some Tree has a Type of `8` and you add this number to this array when this sprite view
  /// collide with this tree it will not move through it.
  ///
  open var stopWhenCollideTypes = [Int]()

  // MARK: - Private properties

  private var analog: Analog? {
    didSet {
      if oldValue != analog {
        changeMovment()
      }
    }
  }

  private var xSpeed: CGFloat = 5
  private var ySpeed: CGFloat = 5

  // The `x` and `y` that you can set to reach to some x and y in the `SceneView`.
  private var desireX: CGFloat?
  private var desireY: CGFloat?

  private var imageView: UIImageView!

  // MARK: - init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: - Public

  ///
  /// It can be overrided to do extra setups in the subview side.
  ///
  open func setup() {
    imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    addSubview(imageView)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView!.topAnchor.constraint(equalTo: topAnchor),
      imageView!.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView!.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView!.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  ///
  /// Make the sprite move to specific `x` and `y`.
  ///
  open func moveTo(x: CGFloat, y: CGFloat) {
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

    // Set the final X and Y for the `Analog`, if the `xMovementPercentage` was 0.5 and the
    // `xDefrence` was 0.2 it the new x will be 0.1,
    // and if the `yMovementPercentage` was 0.5 and the `yDefrence` was 1 then the value will be
    // it will be 0.5.
    // this will make the `SpriteView` move to the right slower than it's moving to down.
    let newX = (xMovementPercentage * xDefrence)
    let newY = (yMovementPercentage * yDefrence)

    // direction value is from 0 to 1 as the `Direction` enum.
    // check `Direction` enum.
    var directionX: CGFloat = newX + 0.5
    var directionY: CGFloat = newY + 0.5
    directionX = directionX > 1 ? 1 : directionX
    directionY = directionY > 1 ? 1 : directionY

    // set the analog for the sprite.
    analog = Analog(direction: Direction(x: directionX, y: directionY), x: newX, y: newY)
  }

  ///
  /// By setting this, you are attaching this `SpriteView` to Analog to control it, each sprite view has
  /// one analog to control it.
  ///
  open func attachTo(_ analogView: AnalogView) {
    analog = analogView.analog
    analogView.analogDidMove { [unowned self] (analog) in
      self.analog = analog
    }
  }

  override open func onCollisionEnter(with object: ObjectView?) {
    guard let object = object, stopWhenCollideTypes.contains(object.type) else {
      xSpeed = speed
      ySpeed = speed
      return
    }

    let x = frame.origin.x
    let y = frame.origin.y
    let objectX = object.frame.origin.x
    let objectY = object.frame.origin.y

    frame.origin.x += (x > objectX ? (speed/2 * 0.5) : (speed/2 * -0.5))
    frame.origin.y += (y > objectY ? (speed/2 * 0.5) : (speed/2 * -0.5))
  }
  
  override open func update() {
    if let desireX = desireX, let desireY = desireY {
      // check if the sprite view reached to the desire x and y then stop it there.
      let xRange = (desireX - speed)...(desireX + speed)
      let yRange = (desireY - speed)...(desireY + speed)
      if xRange.contains(frame.origin.x) && yRange.contains(frame.origin.y) {
        self.desireX = nil
        self.desireY = nil
        // reset the analog to idel status.
        self.analog = Analog(direction: .center, x: 0, y: 0)
        return
      }
    }
    moveXandYBy(x: analog?.x, y: analog?.y)
  }

  // MARK: - Private

  private func changeMovment() {
    guard let direction = analog?.direction else {
      return // in case the the direction did not change go back.
    }
    imageView.animationImages = frames.framesFor(direction)
    imageView.animationDuration = frames.duration
    imageView.startAnimating()
  }

  private func moveXandYBy(x: CGFloat?, y: CGFloat?) {
    if let x = x, let y = y {
      frame.origin.x += (xSpeed * x)
      frame.origin.y += (ySpeed * y)
    }
  }

}
