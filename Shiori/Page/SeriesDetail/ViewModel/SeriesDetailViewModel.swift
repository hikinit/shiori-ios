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

  let cellId = "BookmarkCell"
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

  func deleteCover() {
    series.cover = nil
    library.updateSeries(series)

    if let coverURL = series.cover?.lastPathComponent {
      let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let fileURL = documentsDirectory.appendingPathComponent(coverURL)

      do {
        try FileManager.default.removeItem(atPath: fileURL.path)
      } catch {
        return
      }
    }
  }

  func deleteBookmarkAtIndexPath(_ indexPath: IndexPath, completion: @escaping (Bool) -> () = {_ in}) {
    let bookmark = cellViewModelAtIndexPath(indexPath).bookmark
    let deleted = library.deleteBookmark(bookmark)

    getBookmarks()
    completion(deleted)
  }

  func addNewBookmark(kind: String, number: Float) {
    library.addBookmark(
      number: number,
      kind: Bookmark.Kind.init(rawValue: kind.lowercased())!,
      name: nil,
      to: series)

    getBookmarks()
  }

  func saveSeriesCover(url: URL) {
    series.cover = url

    library.updateSeries(series)
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
