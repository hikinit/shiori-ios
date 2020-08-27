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

  var detailViewModel: SeriesListCellViewModel!
  var series: Series!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupViewModel()
  }

  // MARK: - Setup View
  private func setupView() {
    let headerViewSize = CGSize(width: tableView.bounds.width, height: 220)
    headerView = SeriesDetailHeaderView(frame: CGRect(origin: .zero, size: headerViewSize))

    tableView.tableHeaderView = headerView
    navigationItem.largeTitleDisplayMode = .never
  }

  override func viewWillAppear(_ animated: Bool) {
    fillUI()
  }

  private func fillUI() {
    headerView.setup(with: detailViewModel)
  }

  // MARK: - Actions
  private func deleteSeries() {
    let deleteAlert = AlertBuilder(style: .alert)
      .setTitle("Delete Confirmation")
      .setMessage("Are you sure you want to delete \(detailViewModel.title)")
      .addDestructiveAction("I want to Delete")
      .build()

    present(deleteAlert, animated: true)
  }

  // MARK: - View Model
  private func setupViewModel() {
    detailViewModel = SeriesListCellViewModel(series: series)
  }
}

// MARK: - Segue
extension SeriesDetailViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "SeriesFormViewController":
      guard let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? SeriesFormViewController,
            let cellViewModel = detailViewModel
      else { return }

      vc.series = cellViewModel.series
    default:
      break
    }
  }
}
