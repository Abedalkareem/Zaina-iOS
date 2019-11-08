//
//  LightNodeView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class LightNodeView: NodeView {

  var isOn = false {
    didSet {
      imageView.image = isOn ? #imageLiteral(resourceName: "light_on") :  #imageLiteral(resourceName: "light_off")
    }
  }

}
