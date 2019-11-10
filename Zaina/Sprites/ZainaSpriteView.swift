//
//  ZainaSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ZainaSpriteView: SpriteView {

  let width = 40
  let height = 40

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.zain

    stopWhenCollideTypes = [CollideTypes.house,
                            CollideTypes.exit,
                            CollideTypes.food,
                            CollideTypes.tree,
                            CollideTypes.darkSoul,
                            CollideTypes.light,
                            CollideTypes.dish,
                            CollideTypes.oven]

    frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
  }
}
