//
//  DarkSoulSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class DarkSoulSpriteView: SpriteView {

  let width = 40
  let height = 40

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.darkSoul

    stopWhenCollideTypes = [CollideTypes.house,
                            CollideTypes.tree,
                            CollideTypes.zain]

    frames.top = [#imageLiteral(resourceName: "monster_top_1"), #imageLiteral(resourceName: "monster_top_2")]
    frames.left = [#imageLiteral(resourceName: "monster_left_1"), #imageLiteral(resourceName: "monster_left_2")]
    frames.right = [#imageLiteral(resourceName: "monster_right_1"), #imageLiteral(resourceName: "monster_right_2")]
    frames.bottom = [#imageLiteral(resourceName: "monster_bottom_1"), #imageLiteral(resourceName: "monster_bottom_2")]
    frames.idel = [#imageLiteral(resourceName: "monster_idel_1"), #imageLiteral(resourceName: "monster_idel_2")]
  }
}
