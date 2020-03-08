//
//  ObjectView.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// The parent class for the `NodeView` and `SpriteView`.
/// this has the common properties and methods like the update method and the type property
///
open class ObjectView: UIView {

  // MARK: - IBInspectables

  ///
  /// The type of the `ObjectView` is a unique number for the same kind of objects, like the trees or enemy.
  /// This will be used when to object collides together. and if should the object stop when colliding with another object.
  ///
  @IBInspectable open var type: Int = 0

  // MARK: - Properties

  ///
  /// A unique id for each object.
  ///
  open var id: String = { return UUID().uuidString }()

  // MARK: - Private properties

  private var timer: Timer?

  // MARK: - init

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  @objc
  open func update() { }

  open func onCollisionEnter(with object: ObjectView?) { }
}
