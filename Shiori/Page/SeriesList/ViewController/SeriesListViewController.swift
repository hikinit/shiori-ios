//
//  SeriesListViewController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListViewController: UIViewController, ViewControllerWithStoryboard {

  var viewModel: SeriesListViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
  }

  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack())
    viewModel = .init(library: library)
  }

}

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
