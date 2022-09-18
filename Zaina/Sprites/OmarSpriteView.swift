//
//  OmarSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class OmarSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 40

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.omar

    frames.top = Frames(images: [#imageLiteral(resourceName: "omar_up_1"), #imageLiteral(resourceName: "omar_up_2")], duration: 0.3)
    frames.left = Frames(images: [#imageLiteral(resourceName: "omar_left_1"), #imageLiteral(resourceName: "omar_left_2")], duration: 0.3)
    frames.right = Frames(images: [#imageLiteral(resourceName: "omar_right_1"), #imageLiteral(resourceName: "omar_right_2")], duration: 0.3)
    frames.bottom = Frames(images: [#imageLiteral(resourceName: "omar_bottom_1"), #imageLiteral(resourceName: "omar_bottom_2")], duration: 0.3)
    frames.idel = Frames(images: [#imageLiteral(resourceName: "omar_idel_1"), #imageLiteral(resourceName: "omar_idel_2")], duration: 0.3)
  }
}
