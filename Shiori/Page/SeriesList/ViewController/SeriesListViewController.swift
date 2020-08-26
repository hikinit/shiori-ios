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
    setupLongPress()

    viewModel.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    viewModel.reloadDataSource()
  }

  // MARK: - Long Press Gesture
  private func setupLongPress() {
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
    view.addGestureRecognizer(longPress)
  }

  @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
    guard sender.state == .began,
          let indexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView))
    else { return }

    let cell = viewModel.cellViewModelsAtIndexPath(indexPath)
    let alert = UIAlertController(title: cell.title, message: nil, preferredStyle: .actionSheet)
    let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
      self.performSegue(withIdentifier: "SeriesFormViewController", sender: cell)
    }
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

    alert.addAction(editAction)
    alert.addAction(deleteAction)
    alert.addAction(cancelAction)

    present(alert, animated: true)
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

// MARK: - Segue
extension SeriesListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "SeriesFormViewController":
      guard let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? SeriesFormViewController,
            let cellViewModel = sender as? SeriesListCellViewModel
      else { return }

      vc.series = cellViewModel.series
    default:
      break
    }
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
