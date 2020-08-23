//
//  SeriesListViewModel.swift
//  Shiori
//
//  Created by hikinit on 22/08/20.
//

import Foundation

class SeriesListViewModel {
  private var library: Library

  var numberOfRows = 0
  var viewDidLoad = {}

  private var dataSource = [SeriesListCellViewModel]()
  private var allSeries = [Series]() {
    didSet {
      configureDataSource()
    }
  }


  init(library: Library) {
    self.library = library

    viewDidLoad = { [weak self] in
      self?.getAllSeries()
    }
  }

  func getAllSeries() {
    allSeries = library.getAllSeries()
  }

  func configureDataSource() {
    dataSource = allSeries.map { SeriesListCellViewModel(series: $0) }
    numberOfRows = dataSource.count
  }

  func cellViewModelsAtIndexPath(_ indexPath: IndexPath) -> SeriesListCellViewModel {
    return dataSource[indexPath.item]
  }
}
