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
    collectionView.register(
      UINib(nibName: String(describing: SeriesListViewCell.self), bundle: nil),
      forCellWithReuseIdentifier: viewModel.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self

    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.estimatedItemSize = .zero
    }
  }

  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack())
    viewModel = SeriesListViewModel(library: library)
  }

  var viewModel: SeriesListViewModel!
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
