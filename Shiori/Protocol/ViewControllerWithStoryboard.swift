//
//  ViewControllerWithStoryboard.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

protocol ViewControllerWithStoryboard {
  static var storyboardID: String { get }
  static var storyboardName: String { get }
}

extension ViewControllerWithStoryboard {
  static var storyboardID: String {
    String(describing: Self.self)
  }

  static var storyboardName: String {
    String(describing: Self.self)
  }

  static func loadFromStoryboard<T>() -> T where T: UIViewController {
    let storyboard = UIStoryboard(name: Self.storyboardName, bundle: nil)

    guard let vc = storyboard.instantiateViewController(identifier: Self.storyboardID) as? T else {
      fatalError("Error, can't load \(Self.self) from storyboard")
    }

    return vc
  }
}
