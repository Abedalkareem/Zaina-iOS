//
//  BackgroundView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {

  @IBInspectable var image: UIImage = UIImage() {
     didSet {
       imageView.image = image
     }
   }
  
  private let imageView = UIImageView()

  init(frame: CGRect = .zero, image: UIImage) {
    super.init(frame: frame)
    setup(image: image)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup(image: UIImage? = nil) {
    imageView.image = image
    imageView.contentMode = .scaleAspectFill
    addSubview(imageView)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = frame
  }

}
