//
//  Debouncer.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 03/03/2020.
//  Copyright © 2020 abedalkareem. All rights reserved.
//

import Foundation

///
/// Use it to wait for some time before changing a value again.
///
open class Debouncer {

  // MARK: - Private properties

  private let queue = DispatchQueue.main
  private var workItem: DispatchWorkItem?
  private var interval: TimeInterval

  // MARK: - init

  public init(interval: TimeInterval) {
    self.interval = interval
  }

  // MARK: -

  open func debounce(action: @escaping (() -> Void)) {
    workItem?.cancel()
    workItem = DispatchWorkItem(block: { action() })
    queue.asyncAfter(deadline: .now() + interval, execute: workItem!)
  }
}
