//
//  SeriesFormViewModel.swift
//  Shiori
//
//  Created by hikinit on 25/08/20.
//

import Foundation

class SeriesFormViewModel {
  var library: Library
  var series: Series! {
    didSet {
      updateProperties()
    }
  }

  var title: String!
  var kind: String!
  var status: String!
  var website: String!
  var viewDidLoad = {}

  init(library: Library, series: Series?) {
    self.library = library
    self.series = series

    viewDidLoad = { [weak self] in
      self?.updateProperties()
    }
  }

  func saveSeries() -> Series? {
    if series == nil {
      return createNewSeries()
    }

    return updateSeries()
  }

  private func updateSeries() -> Series {
    series.title = title
    series.kind = kind
    series.status = status
    series.website = URL(string: website)
    library.updateSeries(series)

    return series
  }

  private func createNewSeries() -> Series? {
    guard let kind = Series.Kind(rawValue: self.kind),
          let status = Series.Status(rawValue: self.status)
    else { return nil }

    return library.addSeries(
      title: title,
      kind: kind,
      status: status,
      website: website
    )
  }

  private func updateProperties() {
    title = series?.title ?? ""
    kind = series?.kind ?? ""
    status = series?.status ?? ""
    website = series?.website?.absoluteString ?? ""
  }
}
