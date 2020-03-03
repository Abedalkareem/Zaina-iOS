//
//  SpiderSpriteView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class SpiderSpriteView: SpriteView {

  // MARK: - Properties
  
  let width = 40
  let height = 27

  // MARK: - Setup

  override func setup() {
    super.setup()

    frame = CGRect(x: 0, y: 0, width: width, height: height)

    type = CollideTypes.spider

    speed = 15

    let arrayLeft = [ #imageLiteral(resourceName: "spider_left_1"), #imageLiteral(resourceName: "spider_left_2"), #imageLiteral(resourceName: "spider_left_3"), #imageLiteral(resourceName: "spider_left_4"), #imageLiteral(resourceName: "spider_left_5"), #imageLiteral(resourceName: "spider_left_6")]
    let arrayRight = [#imageLiteral(resourceName: "spider_right_1"), #imageLiteral(resourceName: "spider_right_2"), #imageLiteral(resourceName: "spider_right_3"), #imageLiteral(resourceName: "spider_right_4"), #imageLiteral(resourceName: "spider_right_5"), #imageLiteral(resourceName: "spider_right_6")]
    let arrayIdel = [ #imageLiteral(resourceName: "spider_idel_1"),  #imageLiteral(resourceName: "spider_idel_2")]
    frames.top = arrayLeft
    frames.left = arrayLeft
    frames.right = arrayRight
    frames.bottom = arrayRight
    frames.idel = arrayIdel
  }
}
