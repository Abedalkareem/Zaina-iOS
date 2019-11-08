//
//  OmarSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class OmarSpriteView: SpriteView {

  let width = 40
  let height = 40

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.omar

    frames.top = [#imageLiteral(resourceName: "omar_up_1"), #imageLiteral(resourceName: "omar_up_2")]
    frames.left = [#imageLiteral(resourceName: "omar_left_1"), #imageLiteral(resourceName: "omar_left_2")]
    frames.right = [#imageLiteral(resourceName: "omar_right_1"), #imageLiteral(resourceName: "omar_right_2")]
    frames.bottom = [#imageLiteral(resourceName: "omar_bottom_1"), #imageLiteral(resourceName: "omar_bottom_2")]
    frames.idel = [#imageLiteral(resourceName: "omar_idel_1"), #imageLiteral(resourceName: "omar_idel_2")]
  }
}
