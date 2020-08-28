//
//  SeriesListViewModel.swift
//  Shiori
//
//  Created by hikinit on 22/08/20.
//

import Foundation

class SeriesListViewModel {
  private var library: Library

  let cellId = "SeriesCell"
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

  func deleteSeries(_ series: Series, completion: @escaping (Bool) -> () = {_ in }) {
    let deleted = library.deleteSeries(series)
    getAllSeries()
    completion(deleted)
  }

  func reloadDataSource(completion: @escaping () -> () = {}) {
    getAllSeries()
    completion()
  }

  func searchSeries(_ title: String) {
    allSeries = title.count > 0 ?
      library.searchSeries(title) :
      library.getAllSeries()
  }

  private func getAllSeries() {
    allSeries = library.getAllSeries()
  }

  private func configureDataSource() {
    dataSource = allSeries.map { SeriesListCellViewModel(series: $0) }
    numberOfRows = dataSource.count
  }

  func cellViewModelsAtIndexPath(_ indexPath: IndexPath) -> SeriesListCellViewModel {
    return dataSource[indexPath.item]
  }
}
