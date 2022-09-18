//
//  BackgroundView.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 7/26/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

///
/// A view to set as a background for the `SceneView` it could be a normal image or a pattern image.
///
@IBDesignable
open class BackgroundView: UIView {

  // MARK: - IBInspectables

  ///
  /// An image to set as a background, the image could be a normal image or a pattern image.
  /// If you set a pattren image don't forget to set the `ImageType` to `pattern`.
  ///
  @IBInspectable open var image: UIImage = UIImage() {
    didSet {
      updateImage()
    }
  }

  // MARK: - Properties

  ///
  /// The type of the `image` it could be `full` or `pattern`.
  ///
  open var imageType: ImageType = .full

  // MARK: - Private properties

  private lazy var imageView = UIImageView()

  // MARK: - init

  ///
  /// - Parameters:
  ///   - frame: Frame to set for the view.
  ///   - image: An image to set as a background, the image could be a normal image or a pattern image.
  ///            If you set a pattren image don't forget to set the `ImageType` to `pattern`.
  ///   - imageType: The type of the `image` it could be `full` or `pattern`.
  ///
  public init(image: UIImage, frame: CGRect = .zero, imageType: ImageType = .full) {
    super.init(frame: frame)
    self.image = image
    self.imageType = imageType

    setup()
  }

  override  public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    imageView.image = image
    imageView.contentMode = .scaleAspectFill
    addSubview(imageView)

    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  // MARK: -

  private func updateImage() {
    switch imageType {
    case .full:
      imageView.image = image
      backgroundColor = nil
    case .pattern:
      backgroundColor = UIColor(patternImage: image)
      imageView.image = nil
    }
  }

  // MARK: - Enums

  public enum ImageType {
    case pattern
    case full
  }
}
