//
//  Frames.swift
//  Zaina
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
/// You can set the duration of the frames by setting the duration property.
///
open class Frames {
  open var duration = 0.3
  open var top: [UIImage]?
  open var left: [UIImage]?
  open var right: [UIImage]?
  open var bottom: [UIImage]?
  open var idel: [UIImage]?
  open var topLeft: [UIImage]?
  open var bottomLeft: [UIImage]?
  open var topRight: [UIImage]?
  open var bottomRight: [UIImage]?

  ///
  /// A method that will return an array of images to animate depending on the direction you will pass.
  ///
  open func framesFor(_ direction: Direction) -> [UIImage] {
    var movmentImages = [UIImage]()
    switch direction {
    case .left:
      movmentImages = left!
    case .right:
      movmentImages = right!
    case .top:
      movmentImages = top!
    case .bottom:
      movmentImages = bottom!
    case .center:
      movmentImages = idel!
    case .topLeft:
      movmentImages = topLeft ?? left!
    case .bottomLeft:
      movmentImages = bottomLeft ?? left!
    case .topRight:
      movmentImages = topRight ?? right!
    case .bottomRight:
      movmentImages = bottomRight ?? right!
    }
    return movmentImages
  }
}
