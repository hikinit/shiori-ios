//
//  SeriesDetailViewController.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailViewController: UITableViewController, ViewControllerWithStoryboard {
  private var headerView: SeriesDetailHeaderView!

  var detailViewModel: SeriesListCellViewModel!
  var series: Series!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupViewModel()
    fillUI()
  }

  private func setupView() {
    let headerViewSize = CGSize(width: tableView.bounds.width, height: 220)
    headerView = SeriesDetailHeaderView(frame: CGRect(origin: .zero, size: headerViewSize))

    tableView.tableHeaderView = headerView
    navigationItem.largeTitleDisplayMode = .never
  }

  private func fillUI() {
    headerView.setup(with: detailViewModel)
  }

  private func setupViewModel() {
    detailViewModel = SeriesListCellViewModel(series: series)
  }
}
