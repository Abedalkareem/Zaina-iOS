//
//  FireSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation
import SimpleEngine

class FireSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.fire
    speed = 20

    stopWhenCollideTypes = [CollideTypes.spider]

    framesHolder = FramesHolder(idel: Frames(images: [#imageLiteral(resourceName: "knife_bottom")], duration: 0.1))
    framesHolder?.top = Frames(images: [#imageLiteral(resourceName: "knife_top")], duration: 0.1)
    framesHolder?.left = Frames(images: [#imageLiteral(resourceName: "knife_left")], duration: 0.1)
    framesHolder?.bottom = Frames(images: [#imageLiteral(resourceName: "knife_bottom")], duration: 0.1)
    framesHolder?.right = Frames(images: [#imageLiteral(resourceName: "knife_right")], duration: 0.1)
  }

  override func didRechedDesiredPoint() {
    removeFromSuperview()
  }
}
