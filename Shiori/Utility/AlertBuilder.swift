//
//  UIAlertController+Builder.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class AlertBuilder {
  typealias ActionHandler = ((UIAlertAction) -> Void)?
  typealias TextFieldHandler = ((UITextField) -> Void)?

  var title: String?
  var message: String?
  private var actions = [UIAlertAction]()
  private var textFieldHandlers = [TextFieldHandler]()
  private var style: UIAlertController.Style

  init(style: UIAlertController.Style, cancel: Bool = true) {
    self.style = style
    addCancel(cancel)
  }

  func build() -> UIAlertController {
    let vc = UIAlertController(title: title, message: message, preferredStyle: style)

    textFieldHandlers.forEach {
      vc.addTextField(configurationHandler: $0)
    }

    actions.forEach {
      vc.addAction($0)
    }

    return vc
  }

  func setTitle(_ title: String) -> Self {
    return setAndReturn(\.title, to: title)
  }

  func setMessage(_ message: String) -> Self {
    return setAndReturn(\.message, to: message)
  }

  func addTextField(_ handler: TextFieldHandler) -> Self {
    textFieldHandlers.append(handler)
    return self
  }

  func addDefaultAction(_ title: String, handler: ActionHandler = nil) -> Self {
    return addAction(title, style: .default, handler: handler)
  }

  func addDestructiveAction(_ title: String, handler: ActionHandler = nil) -> Self {
    return addAction(title, style: .destructive, handler: handler)
  }

  @discardableResult
  private func addAction(_ title: String, style: UIAlertAction.Style, handler: ActionHandler = nil) -> Self {
    actions.append(UIAlertAction(title: title, style: style, handler: handler))
    return self
  }

  private func addCancel(_ cancel: Bool) {
    if cancel {
      addAction("Cancel", style: .cancel)
    }
  }

  // For fun
  private func setAndReturn<T>(
    _ keyPath: ReferenceWritableKeyPath<AlertBuilder, T>,
    to value: T) -> Self {
    self[keyPath: keyPath] = value
    return self
  }
}
