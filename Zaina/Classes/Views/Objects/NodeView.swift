//
//  NodeView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

@IBDesignable
class NodeView: ObjectView {

  @IBInspectable var image: UIImage = UIImage() {
    didSet {
      backgroundColor = .clear
      imageView.image = image
    }
  }

  private var imageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    imageView = UIImageView()
    addSubview(imageView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = bounds
  }
}
