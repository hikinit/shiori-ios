//
//  SeriesDetailViewModel.swift
//  Shiori
//
//  Created by hikinit on 27/08/20.
//

import Foundation

class SeriesDetailViewModel {
  private var library: Library
  var series: Series

  var headerViewModel: SeriesListCellViewModel
  var numberOfRows = 0
  var viewDidLoad = {}

  private var dataSource = [BookmarkCellViewModel]()
  private var bookmarks = [Bookmark]() {
    didSet {
      configureDataSource()
    }
  }

  init(library: Library, series: Series) {
    self.library = library
    self.series = series
    self.headerViewModel = SeriesListCellViewModel(series: series)

    viewDidLoad = { [weak self] in
      self?.getBookmarks()
    }
  }

  func cellViewModelAtIndexPath(_ indexPath: IndexPath) -> BookmarkCellViewModel {
    return dataSource[indexPath.item]
  }

  func reloadDataSource(completion: @escaping () -> () = {}) {
    getBookmarks()
    completion()
  }

  func deleteThisSeries(completion: @escaping (Bool) -> () = {_ in}) {
    let deleted = library.deleteSeries(series)
    getBookmarks()
    completion(deleted)
  }

  private func getBookmarks() {
    bookmarks = series.arrayBookmarks
  }

  private func configureDataSource() {
    dataSource = bookmarks.map {
      BookmarkCellViewModel(bookmark: $0)
    }
    numberOfRows = dataSource.count
  }
}
