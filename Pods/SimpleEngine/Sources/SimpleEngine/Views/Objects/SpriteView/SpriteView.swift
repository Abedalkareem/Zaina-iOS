//
//  SpriteView.swift
//  SimpleEngine
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
  @IBInspectable open var speed: CGFloat = 5

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
  open var frames = FramesHolder()

  ///
  /// The ` SpriteView` will stop when it collide with one of this types.
  /// Like if some Tree has a Type of `8` and you add this number to this array when this sprite view
  /// collide with this tree it will not move through it.
  ///
  open var stopWhenCollideTypes = [Int]()

  ///
  /// If the value is true, the object will not pass through out the screen edges.
  ///
  open var shouldHitTheEdges = false

  // MARK: - Private properties

  private var analog: Analog? {
    didSet {
      if oldValue != analog {
        changeMovment()
      }
    }
  }

  // The `x` and `y` that you can set to reach to some x and y in the `SceneView`.
  private var desireX: CGFloat?
  private var desireY: CGFloat?

  private var imageView: UIImageView!

  private var stopOtherAnimations = false

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
  /// - Parameters:
  ///   - x: X to move to.
  ///   - y: Y to move to.
  ///   - shouldBeRemovedAtTheEnd: Should it be removed at the end.
  ///   default is `false`.
  ///
  open func moveTo(x: CGFloat, y: CGFloat) {
    self.desireX = x
    self.desireY = y

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

  ///
  /// A method will be called when any object collided with this object.
  /// `super.onCollisionEnter(with object:)` must always be called when
  /// you override this method.
  ///
  /// - Parameter object: The object the collided.
  ///
  /// - Returns: Return true if the object should report the collide to the view controller.
  /// The defualt is `true`.
  ///
  @discardableResult
  override open func onCollisionEnter(with object: ObjectView?) -> Bool {
    guard let object = object, stopWhenCollideTypes.contains(object.type) else {
      return true
    }

    let x = frame.origin.x
    let y = frame.origin.y
    let objectX = object.frame.origin.x
    let objectY = object.frame.origin.y

    frame.origin.x += (x > objectX ? (speed * 0.5) : (speed * -0.5))
    frame.origin.y += (y > objectY ? (speed * 0.5) : (speed * -0.5))

    if let desireX = desireX, let desireY = desireY {
      moveTo(x: desireX, y: desireY)
    }
    return true
  }
  
  override open func update() {
    if let desireX = desireX, let desireY = desireY {
      // check if the sprite view reached to the desire x and y then stop it there.
      let xRange = (desireX - speed)...(desireX + speed)
      let yRange = (desireY - speed)...(desireY + speed)
      if xRange.contains(frame.origin.x) && yRange.contains(frame.origin.y) {
        self.desireX = nil
        self.desireY = nil
        // reset the analog to idel status (if there is an analog attached).
        self.analog = Analog(direction: .center, x: 0, y: 0)
        self.didRechedDesiredPoint()
        return
      }
    }
    moveXandYBy(x: analog?.x, y: analog?.y)
  }

  ///
  /// override to be notifide when the `SpriteView` reaches the
  /// desired point.
  ///
  open func didRechedDesiredPoint() { }

  ///
  /// Use it to update the `SpriteView` in case you changed any of the `Frames`.
  ///
  open func updateFrames() {
    changeMovment()
  }

  /// Animate frames for the sprite.
  /// - Parameters:
  ///   - frames: The frames to animate.
  ///   - repeatCount: How many time should the frames repeated.
  ///   The default is `0`.
  ///   - stopOtherAnimations: Should stop all the other animations
  ///   like the animation for moving or idel. The default is `false`.
  ///   - didFinish: a closure to be called when the animation finishs.
  ///
  open func startAnimationWith(frames: Frames,
                               repeatCount: Int = 0,
                               stopOtherAnimations: Bool = false,
                               didFinish: (() -> Void)? = nil) {
    self.stopOtherAnimations = stopOtherAnimations

    imageView.animationImages = frames.images
    imageView.animationDuration = frames.duration
    imageView.startAnimating()

    let totalAnimationTime = Double(repeatCount) * frames.duration
    guard totalAnimationTime != 0 else {
      return
    }
    let oneFrameDuration = frames.duration / Double(frames.images?.count ?? 0)
    DispatchQueue.main.asyncAfter(deadline: .now() + totalAnimationTime - oneFrameDuration) {
      didFinish?()
      self.imageView.stopAnimating()
      self.imageView.image = frames.images?.last
      self.stopOtherAnimations = false
      self.changeMovment()
    }
  }

  // MARK: - Private

  private func changeMovment() {
    guard let direction = analog?.direction,
      !stopOtherAnimations else {
      return // in case the the direction did not change go back.
    }
    let frames = self.frames.for(direction)
    startAnimationWith(frames: frames)
  }

  private func moveXandYBy(x: CGFloat?, y: CGFloat?) {
    if let x = x, let y = y {
      guard let superview = superview else {
        return
      }
      
      let newX = frame.origin.x + (speed * x)
      let newY = frame.origin.y + (speed * y)

      guard shouldHitTheEdges else {
        frame.origin.x = newX
        frame.origin.y = newY
        return
      }

      let rightEdge = superview.frame.width - frame.width
      let leftEdge = CGFloat(0)

      if newX < leftEdge {
        frame.origin.x = leftEdge
      } else if newX > rightEdge {
        frame.origin.x = rightEdge
      } else {
        frame.origin.x = newX
      }

      let bottomEdge = superview.frame.height - frame.height
      let topEdge = CGFloat(0)

      if newY < topEdge {
        frame.origin.y = topEdge
      } else if newY > bottomEdge {
        frame.origin.y = bottomEdge
      } else {
        frame.origin.y = newY
      }
    }
  }

}
