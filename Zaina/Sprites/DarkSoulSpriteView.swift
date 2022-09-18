//
//  DarkSoulSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class DarkSoulSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.darkSoul
    shouldHitTheEdges = true

    stopWhenCollideTypes = [CollideTypes.house,
                            CollideTypes.tree,
                            CollideTypes.zain]

    framesHolder = FramesHolder(idel: Frames(images: [#imageLiteral(resourceName: "monster_idel_1"), #imageLiteral(resourceName: "monster_idel_2")], duration: 0.3))
    framesHolder?.top = Frames(images: [#imageLiteral(resourceName: "monster_top_1"), #imageLiteral(resourceName: "monster_top_2")], duration: 0.3)
    framesHolder?.left = Frames(images: [#imageLiteral(resourceName: "monster_left_1"), #imageLiteral(resourceName: "monster_left_2")], duration: 0.3)
    framesHolder?.right = Frames(images: [#imageLiteral(resourceName: "monster_right_1"), #imageLiteral(resourceName: "monster_right_2")], duration: 0.3)
    framesHolder?.bottom = Frames(images: [#imageLiteral(resourceName: "monster_bottom_1"), #imageLiteral(resourceName: "monster_bottom_2")], duration: 0.3)
  }
}
