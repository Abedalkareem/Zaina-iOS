//
//  DialogView.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

open class DialogView: UIView {

  public typealias ActionClosure = (Action) -> Void

  // MARK: - Properties

  ///
  /// Dialog text font name.
  ///
  public static var fontName = ""

  ///
  /// A message to show in the dialog.
  ///
  open var message = "" {
    didSet {
      label.text = message
    }
  }

  ///
  /// First button title.
  ///
  open var firstButtonTitle = "" {
    didSet {
      firstButton.setTitle(firstButtonTitle, for: .normal)
    }
  }

  ///
  /// Second button title.
  ///
  open var secondButtonTitle = "" {
    didSet {
      secondButton.setTitle(secondButtonTitle, for: .normal)
    }
  }

  // MARK: - Private properties

  private var label = UILabel()
  private var firstButton = UIButton()
  private var secondButton = UIButton()

  private var backgroundView = UIView()
  private var action: ActionClosure?

  // MARK: - init

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {

    translatesAutoresizingMaskIntoConstraints = false
    layer.cornerRadius = 20
    layer.masksToBounds = true
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 2

    backgroundView = UIView()
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    backgroundView.backgroundColor = .black
    backgroundView.alpha = 0.7
    addSubview(backgroundView)

    label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.numberOfLines = 0
    label.font = UIFont(name: DialogView.fontName, size: 17)
    addSubview(label)

    firstButton = UIButton()
    firstButton.translatesAutoresizingMaskIntoConstraints = false
    firstButton.setTitleColor(.white, for: .normal)
    firstButton.titleLabel?.font = UIFont(name: DialogView.fontName, size: 17)
    firstButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
    addSubview(firstButton)

    secondButton = UIButton()
    secondButton.translatesAutoresizingMaskIntoConstraints = false
    secondButton.setTitleColor(.white, for: .normal)
    secondButton.titleLabel?.font = UIFont(name: DialogView.fontName, size: 17)
    secondButton.addTarget(self, action: #selector(secondAction), for: .touchUpInside)
    addSubview(secondButton)

    makeConstraint()
  }

  private func makeConstraint() {
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 20)
    ])

    NSLayoutConstraint.activate([
      firstButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      firstButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
      firstButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])

    NSLayoutConstraint.activate([
      secondButton.trailingAnchor.constraint(equalTo: firstButton.leadingAnchor, constant: -20),
      secondButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
      secondButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
    ])
  }

  open func dismiss() {
    animate(isShowing: false) { _ in
      self.removeFromSuperview()
    }
  }

  open func animate(isShowing: Bool, completion: ((Bool) -> Void)? = nil) {
    alpha = isShowing ? 0 : 1
    UIView.animate(withDuration: 0.5,
                   animations: {
      self.alpha = isShowing ? 1 : 0
    }, completion: completion)
  }

  // MARK: - Actions

  @objc
  private func firstAction() {
    action?(.first)
    dismiss()
  }

  @objc
  private func secondAction() {
    action?(.second)
    dismiss()
  }

  // MARK: - Show

  open class func showIn(view: UIView,
                         message: String,
                         firstButtonTitle: String,
                         secondButtonTitle: String = "",
                         action: ActionClosure? = nil) {
    let dialogView = DialogView()
    dialogView.message = message
    dialogView.firstButtonTitle = firstButtonTitle
    dialogView.secondButtonTitle = secondButtonTitle
    dialogView.action = action
    view.addSubview(dialogView)
    NSLayoutConstraint.activate([
      dialogView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dialogView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      dialogView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ])

    dialogView.animate(isShowing: true)
  }

  // MARK: - Enums

  public enum Action {
    case first
    case second
  }

}
