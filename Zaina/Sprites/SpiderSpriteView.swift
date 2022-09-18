//
//  SpiderSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class SpiderSpriteView: SpriteView {

  // MARK: - Properties

  let width = 40
  let height = 27

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.spider
    shouldHitTheEdges = true

    speed = 15

    let arrayLeft = Frames(images: [ #imageLiteral(resourceName: "spider_left_1"), #imageLiteral(resourceName: "spider_left_2"), #imageLiteral(resourceName: "spider_left_3"), #imageLiteral(resourceName: "spider_left_4"), #imageLiteral(resourceName: "spider_left_5"), #imageLiteral(resourceName: "spider_left_6")], duration: 0.3)
    let arrayRight = Frames(images: [#imageLiteral(resourceName: "spider_right_1"), #imageLiteral(resourceName: "spider_right_2"), #imageLiteral(resourceName: "spider_right_3"), #imageLiteral(resourceName: "spider_right_4"), #imageLiteral(resourceName: "spider_right_5"), #imageLiteral(resourceName: "spider_right_6")], duration: 0.3)
    let arrayIdel = Frames(images: [ #imageLiteral(resourceName: "spider_idel_1"),  #imageLiteral(resourceName: "spider_idel_2")], duration: 0.3)
    frames.top = arrayLeft
    frames.left = arrayLeft
    frames.right = arrayRight
    frames.bottom = arrayRight
    frames.idel = arrayIdel
  }
}
