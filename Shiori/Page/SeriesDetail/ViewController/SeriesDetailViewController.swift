//
//  SeriesDetailViewController.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailViewController: UITableViewController, ViewControllerWithStoryboard {
  private var headerView: SeriesDetailHeaderView!
  @IBAction func trashDidTap(_ sender: UIBarButtonItem) {
    deleteSeries()
  }

  @IBAction func addDidTap(_ sender: UIBarButtonItem) {
    addBookmark()
  }

  var series: Series!
  var viewModel: SeriesDetailViewModel!
  var kindPickerDataSource: PickerDataSource!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    setupView()
  }

  // MARK: - Setup View
  private func setupView() {
    let headerViewSize = CGSize(width: tableView.bounds.width, height: 220)
    headerView = SeriesDetailHeaderView(frame: CGRect(origin: .zero, size: headerViewSize))

    tableView.tableHeaderView = headerView
    tableView.register(BookmarkCellView.self, forCellReuseIdentifier: viewModel.cellId)

    navigationItem.largeTitleDisplayMode = .never
  }

  override func viewWillAppear(_ animated: Bool) {
    viewModel.reloadDataSource()

    print(viewModel.numberOfRows)

    fillUI()
  }

  private func fillUI() {
    headerView.setup(with: viewModel.headerViewModel)
  }

  // MARK: - Actions
  private func deleteSeries() {
    let deleteAlert = AlertBuilder(style: .alert)
      .setTitle("Delete Confirmation")
      .setMessage("Are you sure you want to delete \(viewModel.headerViewModel.title)?")
      .addDestructiveAction("I want to Delete") { [weak self] _ in
        self?.viewModel.deleteThisSeries {
          guard $0 else { return }
          self?.navigationController?.popViewController(animated: true)
        }
      }
      .build()

    present(deleteAlert, animated: true)
  }

  // MARK: - View Model
  func setupViewModel() {
    viewModel = SeriesDetailViewModel(library: Library.shared, series: series)
  }
}

// MARK: - Segue
extension SeriesDetailViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "SeriesFormViewController":
      guard let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? SeriesFormViewController
      else { return }

      vc.series = viewModel.series
    default:
      break
    }
  }
}
