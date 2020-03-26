//
//  ZainaSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class ZainaSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup
  
  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.zain
    shouldHitTheEdges = true

    stopWhenCollideTypes = [CollideTypes.house,
                            CollideTypes.exit,
                            CollideTypes.food,
                            CollideTypes.tree,
                            CollideTypes.darkSoul,
                            CollideTypes.light,
                            CollideTypes.dish,
                            CollideTypes.oven,
                            CollideTypes.wall]

    frames.top = Frames(images: [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")], duration: 0.3)
    frames.left = Frames(images: [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")], duration: 0.3)
    frames.right = Frames(images: [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")], duration: 0.3)
    frames.bottom = Frames(images: [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")], duration: 0.3)
    frames.idel = Frames(images: [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")], duration: 0.3)
  }
}
