//
//  SeriesDetailViewController.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailViewController: UITableViewController, ViewControllerWithStoryboard {
  var detailViewModel: SeriesListCellViewModel!
  var series: Series!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    setupView()
  }

  private func setupView() {
    let headerViewSize = CGSize(width: tableView.bounds.width, height: 200)
    let headerView = SeriesDetailHeaderView(frame: CGRect(origin: .zero, size: headerViewSize))

    tableView.tableHeaderView = headerView
    navigationItem.largeTitleDisplayMode = .never
  }

  private func setupViewModel() {
    detailViewModel = SeriesListCellViewModel(series: series)
  }
}
