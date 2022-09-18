//
//  SceneView.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// A view where you will add the `Sprites` or `Nodes`. You can think of this as level.
/// Each `BaseGameViewController` should have 1 scene, and should be connected throgh `IBOutlet`.
///
@IBDesignable
open class SceneView: UIView {

  // MARK: - Properties

  open var paused: Bool = false {
    didSet {
      pauseObjects(paused: paused)
    }
  }

  // MARK: - init

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    backgroundColor = .clear
  }

  private func pauseObjects(paused: Bool) {
    subviews
      .compactMap { $0 as? ObjectView }
      .forEach { $0.paused = paused }
  }

}
