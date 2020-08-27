//
//  SeriesDetailViewModel.swift
//  Shiori
//
//  Created by hikinit on 27/08/20.
//

import Foundation

class SeriesDetailViewModel {
  private var library: Library

  var detailViewModel: SeriesListCellViewModel
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
    self.detailViewModel = SeriesListCellViewModel(series: series)

    viewDidLoad = { [weak self] in
      self?.getBookmarks()
    }
  }

  func cellViewModelAtIndexPath(_ indexPath: IndexPath) -> BookmarkCellViewModel {
    return dataSource[indexPath.item]
  }

  func reloadDataSource(completion: @escaping () -> ()) {
    getBookmarks()
    completion()
  }

  func deleteThisSeries(completion: @escaping () -> ()) {
    library.deleteSeries(detailViewModel.series)
    completion()
  }

  private func getBookmarks() {
    bookmarks = detailViewModel.series.arrayBookmarks
  }

  private func configureDataSource() {
    dataSource = bookmarks.map {
      BookmarkCellViewModel(bookmark: $0)
    }
    numberOfRows = dataSource.count
  }
}
