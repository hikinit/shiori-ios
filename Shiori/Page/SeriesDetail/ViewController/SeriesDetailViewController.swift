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
    navigationItem.largeTitleDisplayMode = .never
  }

  private func setupViewModel() {
    detailViewModel = SeriesListCellViewModel(series: series)
  }
}
