//
//  MovingBackgroundView.swift
//  Pods-Virus
//
//  Created by abedalkareem omreyh on 10/03/2020.
//

import UIKit

public class MovingBackgroundView: UIView {

  // MARK: - Properties

  public var view: UIView? {
    didSet {
      oldValue?.removeFromSuperview()
      setup()
    }
  }

  // MARK: - Private properties

  private var secondView: UIView? {
     didSet {
       oldValue?.removeFromSuperview()
     }
   }
  // MARK: - init

  public init(view: UIView) {
    super.init(frame: .zero)
    self.view = view
    setup()
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    secondView = view?.snapshotView(afterScreenUpdates: true)
    if let view = view, let secondView = secondView {
      addSubview(view)
      addSubview(secondView)
    }

    playAnimation()
    addObservers()
  }

  // MARK: - View lifecycle

  override public func didMoveToSuperview() {
    super.didMoveToSuperview()

    if superview == nil {
      removeObservers()
    }
  }

  // MARK: - Observers

  private func addObservers() {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(playAnimation),
                   name: UIApplication.didBecomeActiveNotification,
                   object: nil)
  }

  private func removeObservers() {
    NotificationCenter.default
      .removeObserver(self,
                      name: UIApplication.didBecomeActiveNotification,
                      object: nil)
  }

  // MARK: - Animations

  @objc
  private func playAnimation() {
    animate()
    animateSecondView()
  }

  private func animate() {
    guard let view = view else {
      return
    }
    let orginalFrame = bounds
    var newFrame = orginalFrame
    newFrame.origin.x = -orginalFrame.size.width
    view.frame = newFrame
    UIView.animate(withDuration: 0.5,
                   delay: .zero,
                   options: [.repeat, .curveLinear]) {
      view.frame = orginalFrame
    }
  }

  private func animateSecondView() {
    guard let secondView = secondView else {
      return
    }
    let orginalFrame = bounds
    var newFrame = orginalFrame
    newFrame.origin.x = +orginalFrame.size.width
    secondView.frame = orginalFrame
    UIView.animate(withDuration: 0.5,
                   delay: .zero,
                   options: [.repeat, .curveLinear]) {
      secondView.frame = newFrame
    }
  }
}
