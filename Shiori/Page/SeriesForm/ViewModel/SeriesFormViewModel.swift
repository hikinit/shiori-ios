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

  var viewControllerTitle = "New Series"

  var title: String! {
    didSet {
      verifyProperties()
    }
  }
  
  var kind: String! {
    didSet {
      verifyProperties()
    }
  }

  var status: String! {
    didSet {
      verifyProperties()
    }
  }

  var website: String!
  var viewDidLoad = {}
  var saveButtonIsEnabled = false

  var kindOptions = Series.Kind.allCases.map { $0.rawValue }
  var statusOptions = Series.Status.allCases.map { $0.rawValue.capitalized }

  init(library: Library, series: Series?) {
    self.library = library
    self.series = series

    viewDidLoad = { [weak self] in
      self?.updateProperties()
    }
  }

  private func updateProperties() {
    viewControllerTitle = series?.title ?? viewControllerTitle
    title = series?.title ?? ""
    kind = series?.kind ?? ""
    status = series?.status?.capitalized ?? ""
    website = series?.website?.absoluteString ?? ""
  }

  private func verifyProperties() {
    guard let title = title, let status = status, let kind = kind else { return }
    let enabled = title.count >= 5
      && !status.isEmpty
      && !kind.isEmpty

    saveButtonIsEnabled = enabled
  }


  @discardableResult
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
          let status = Series.Status(rawValue: self.status.lowercased())
    else { return nil }

    return library.addSeries(
      title: title,
      kind: kind,
      status: status,
      website: website
    )
  }
}
