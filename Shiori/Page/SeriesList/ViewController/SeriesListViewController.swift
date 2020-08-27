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

    let deleteAlert = AlertBuilder(style: .alert)
      .setTitle("Delete Confirmation")
      .setMessage("Are you sure you want to delete \(cell.title)?")
      .addDestructiveAction("I want to Delete") { [weak self] _ in
        self?.viewModel.deleteSeries(cell.series) {
          guard $0 else { return }
          self?.collectionView.reloadData()
        }
      }
      .build()

    let actionSheet = AlertBuilder(style: .actionSheet)
      .setTitle(cell.title)
      .addDefaultAction("Edit") { _ in
        self.performSegue(withIdentifier: "SeriesFormViewController", sender: cell)
      }
      .addDestructiveAction("Delete") { _ in
        self.present(deleteAlert, animated: true)
      }
      .build()

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

