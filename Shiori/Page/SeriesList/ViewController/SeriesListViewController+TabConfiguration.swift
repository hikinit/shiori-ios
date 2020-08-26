//
//  SeriesListViewController+TabConfiguration.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

// MARK: - TabBarController configuration
extension SeriesListViewController {
  struct TabConfiguration {
    static let title = "Series"
    static let item = UITabBarItem(
      title: Self.title,
      image: UIImage(systemName: "book"),
      selectedImage: UIImage(systemName: "book.fill")
    )
  }
}
