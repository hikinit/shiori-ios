//
//  SeriesListViewController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit
import Combine

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

    viewModel.reloadDataSource { [weak self] in
      self?.collectionView.reloadData()
    }
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

    let actionSheet = actionSheetAtIndexPath(indexPath: indexPath)
    present(actionSheet, animated: true)
  }

  // MARK: - Action Sheet
  func actionSheetAtIndexPath(indexPath: IndexPath) -> UIAlertController {
    let cell = viewModel.cellViewModelsAtIndexPath(indexPath)
    let actionSheet = UIAlertController(title: cell.title, message: nil, preferredStyle: .actionSheet)
    let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
      self.performSegue(withIdentifier: "SeriesFormViewController", sender: cell)
    }
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

    actionSheet.addAction(editAction)
    actionSheet.addAction(deleteAction)
    actionSheet.addAction(cancelAction)

    return actionSheet
  }

  // MARK: - CollectionView
  private func setupCollectionView() {
    collectionView.register(
      UINib(nibName: String(describing: SeriesListViewCell.self), bundle: nil),
      forCellWithReuseIdentifier: viewModel.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.alwaysBounceVertical = true

    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.estimatedItemSize = .zero
    }
  }

  // MARK: - View Model
  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack.shared)
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

