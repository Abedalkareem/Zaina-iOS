//
//  LivesView.swift
//  Virus
//
//  Created by abedalkareem omreyh on 11/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import UIKit

@IBDesignable
open class LivesView: UIView {

  public typealias LivesDidUpdate = (Int) -> Void

  // MARK: - IBInspectables

  ///
  /// Background image bottom inset.
  ///
  @IBInspectable open var bottomInset: CGFloat = 0 {
    didSet { backgroundImageInsets.bottom = bottomInset }
  }
  ///
  /// Background image left inset.
  ///
  @IBInspectable open var leftInset: CGFloat = 0 {
    didSet { backgroundImageInsets.left = leftInset }
  }
  ///
  /// Background image right inset.
  ///
  @IBInspectable open var rightInset: CGFloat = 0 {
    didSet { backgroundImageInsets.right = rightInset }
  }
  ///
  /// Background image top inset.
  ///
  @IBInspectable open var topInset: CGFloat = 0 {
    didSet { backgroundImageInsets.top = topInset }
  }

  ///
  /// An image to set as a background.
  ///
  @IBInspectable open var backgroundImage: UIImage = UIImage() {
    didSet {
      updateBackgroundImage()
    }
  }

  ///
  /// An image to show as a live.
  ///
  @IBInspectable open var liveImage: UIImage = UIImage()

  ///
  /// Space Between lives. The default is `4`.
  ///
  @IBInspectable open var spacing: CGFloat = 4 {
    didSet {
      stackView.spacing = spacing
    }
  }

  // MARK: - Properties

  ///
  /// Number of lives. The default value is `0`.
  ///
  open var livesCount: Int = 0 {
    didSet {
      currentLivesCount = livesCount
    }
  }
  
  ///
  /// Current number of lives. This will be changed
  /// when you remove or add lives.
  ///
  open var currentLivesCount: Int = 0 {
    didSet {
      livesUpdated(oldNumber: oldValue)
      _livesDidUpdate?(currentLivesCount)
    }
  }

  // MARK: - Private properties

  private var backgroundImageView: UIImageView!
  private var stackView: UIStackView!

  private var backgroundImageInsets: UIEdgeInsets = .zero
  private var _livesDidUpdate: LivesDidUpdate?

  // MARK: - init

  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required public init(coder: NSCoder) {
    super.init(coder: coder)!
    setup()
  }

  private func setup() {

    backgroundColor = .clear

    backgroundImageView = UIImageView()
    backgroundImageView.contentMode = .scaleToFill
    addSubview(backgroundImageView)

    stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .leading
    stackView.spacing = spacing
    addSubview(stackView)
    
    makeConstraints()
  }

  private func makeConstraints() {

    let spacing: CGFloat = 16
    let topSpacing: CGFloat = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topSpacing),
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: topSpacing),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -spacing),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing)
    ])

    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }

  private func updateBackgroundImage() {
    backgroundImageView.image = backgroundImage
      .resizableImage(withCapInsets: backgroundImageInsets)
  }

  // MARK: - View lifecycle

  open override func layoutSubviews() {
    super.layoutSubviews()
    updateBackgroundImage()
  }

  private func livesUpdated(oldNumber: Int) {
    let isRemoving = oldNumber > currentLivesCount
    let number = abs(currentLivesCount - oldNumber)
    if isRemoving {
      (0..<number)
        .map { stackView.arrangedSubviews[$0] }
        .forEach { $0.removeFromSuperview() }
    } else {
      (0..<number)
        .forEach { _ in
          let imageView = UIImageView(image: liveImage)
          imageView.contentMode = .scaleAspectFit
          stackView.addArrangedSubview(imageView)
      }
    }
  }

  // MARK: - Public methods

  ///
  /// Add more lives to the current lives.
  ///
  open func add(_ number: Int) {
    currentLivesCount += number
  }

  ///
  /// Add lives from the current lives.
  ///
  open func remove(_ number: Int) {
    guard currentLivesCount != 0 else {
      return
    }
    currentLivesCount -= number
  }

  ///
  /// It will be called whenever the lives number updated.
  ///
  open func livesDidUpdate(_ livesDidUpdate: @escaping LivesDidUpdate) {
    self._livesDidUpdate = livesDidUpdate
  }
}
