//
//  SeriesListViewController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListViewController: UIViewController {

  struct TabConfiguration {
    static let title = "Series"
    static let item = UITabBarItem(
      title: Self.title,
      image: UIImage(systemName: "book"),
      selectedImage: UIImage(systemName: "book.fill")
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
