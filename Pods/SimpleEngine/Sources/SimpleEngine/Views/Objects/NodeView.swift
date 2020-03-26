//
//  NodeView.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// A `NodeView` is a thing that don't move, it's a chair, table or wall in your game.
///
@IBDesignable
open class NodeView: ObjectView {

  // MARK: - IBInspectables

  @IBInspectable open var image: UIImage = UIImage() {
    didSet {
      backgroundColor = .clear
      imageView.image = image
    }
  }

  // MARK: - Private properties

  private var imageView: UIImageView!

  // MARK: - init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  ///
  /// It can be overrided to do extra setups in the subview side.
  ///
  open func setup() {
    imageView = UIImageView()
    addSubview(imageView)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView!.topAnchor.constraint(equalTo: topAnchor),
      imageView!.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView!.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView!.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}
