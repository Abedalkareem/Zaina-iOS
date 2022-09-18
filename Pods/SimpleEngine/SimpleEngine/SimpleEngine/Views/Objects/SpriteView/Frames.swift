//
//  Frames.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// To set a frames for the movment of the `SpriteView`. You can set the images (frames) that will show
/// when the user move to right, left, top, bottom, topLeft, bottomLeft, topRight, bottomRight or idel.
/// If you did not pass the topLeft or bottomLeft the left images will be used, same for topRight and bottomRight you
/// will get right images.
/// At least you need to pass the idel images and it will be used for
/// all the frames.
/// You can set the duration of the frames by setting the duration property.
///
open class FramesHolder {
  open var top: Frames?
  open var left: Frames?
  open var right: Frames?
  open var bottom: Frames?
  open var idel: Frames
  open var topLeft: Frames?
  open var bottomLeft: Frames?
  open var topRight: Frames?
  open var bottomRight: Frames?

  public init(idel: Frames,
              top: Frames? = nil,
              left: Frames? = nil,
              right: Frames? = nil,
              bottom: Frames? = nil,
              topLeft: Frames? = nil,
              bottomLeft: Frames? = nil,
              topRight: Frames? = nil,
              bottomRight: Frames? = nil) {
    self.top = top
    self.left = left
    self.right = right
    self.bottom = bottom
    self.idel = idel
    self.topLeft = topLeft
    self.bottomLeft = bottomLeft
    self.topRight = topRight
    self.bottomRight = bottomRight
  }

  ///
  /// A method that will return an array of images to animate depending on the direction you will pass.
  ///
  open func `for`(_ direction: Direction) -> Frames {
    var frame: Frames
    switch direction {
    case .left:
      frame = left ?? idel
    case .right:
      frame = right ?? idel
    case .top:
      frame = top ?? idel
    case .bottom:
      frame = bottom ?? idel
    case .center:
      frame = idel
    case .topLeft:
      frame = topLeft ?? left ?? idel
    case .bottomLeft:
      frame = bottomLeft ?? left ?? idel
    case .topRight:
      frame = topRight ?? right ?? idel
    case .bottomRight:
      frame = bottomRight ?? right ?? idel
    }
    return frame
  }
}

open class Frames {
  open var images: [UIImage]?
  open var duration = 0.3

  public init(images: [UIImage]?, duration: Double = 0.3) {
    self.images = images
    self.duration = duration
  }
}
