//
//  SeriesListCellViewModel.swift
//  Shiori
//
//  Created by hikinit on 23/08/20.
//

import Foundation

class SeriesListCellViewModel {
  var series: Series
  var title: String
  var kind: String
  var status: String
  var hasWebsite: Bool
  var websiteURL: URL?

  init(series: Series) {
    self.series = series
    self.title = series.title ?? ""
    self.kind = series.kind ?? ""
    self.status = series.status?.capitalized ?? ""

    guard let website = series.website else {
      self.hasWebsite = false
      return
    }

    self.hasWebsite = true
    self.websiteURL = website
  }
}

extension SeriesListCellViewModel: Equatable {
  static func == (lhs: SeriesListCellViewModel, rhs: SeriesListCellViewModel) -> Bool {
    return lhs.title == rhs.title && lhs.kind == rhs.kind
  }
}
