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

  private var timer: Timer?

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  @objc
  func update() { }
}
