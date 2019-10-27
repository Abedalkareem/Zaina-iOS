//
//  ObjectView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ObjectView: UIView {

  var id: String = { return UUID().uuidString }()

  @IBInspectable var type: Int = 0

  func onCollisionEnter(with object: ObjectView?) { }
}
