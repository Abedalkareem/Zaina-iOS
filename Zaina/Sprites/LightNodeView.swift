//
//  LightNodeView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

@IBDesignable
class LightNodeView: NodeView {

  // MARK: - Properties

  var debouncer = Debouncer(interval: 0.2)

  private(set) var isOn = false {
    didSet {
      image = isOn ? #imageLiteral(resourceName: "light_on") :  #imageLiteral(resourceName: "light_off")
    }
  }

  func changeValue() {
    debouncer.debounce { [weak self] in
      self?.isOn = !(self?.isOn ?? false)
    }
  }

}
