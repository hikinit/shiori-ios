//
//  SeriesListViewController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListViewController: UIViewController, ViewControllerWithStoryboard {
  // MARK: - View
  @IBOutlet weak var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    setupCollectionView()

    viewModel.viewDidLoad()
  }

  // MARK: - CollectionView
  private func setupCollectionView() {
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    dataSource = SeriesListDataSource(viewModel: viewModel)
    collectionView.dataSource = dataSource
  }

  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack())
    viewModel = SeriesListViewModel(library: library)
  }

  // MARK: - Privates
  private var viewModel: SeriesListViewModel!
  private var dataSource: SeriesListDataSource!
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
