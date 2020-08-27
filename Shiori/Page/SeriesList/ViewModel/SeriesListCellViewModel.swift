//
//  SeriesListCellViewModel.swift
//  Shiori
//
//  Created by hikinit on 23/08/20.
//

import Foundation

class SeriesListCellViewModel {
  var series: Series

  var title: String {
    series.title ?? ""
  }

  var kind: String {
    series.kind ?? ""
  }

  var status: String {
    series.status?.capitalized ?? ""
  }

  var hasWebsite: Bool {
    guard series.website != nil else { return false }
    return true
  }

  var websiteURL: URL? {
    series.website
  }

  init(series: Series) {
    self.series = series
  }
}

extension SeriesListCellViewModel: Equatable {
  static func == (lhs: SeriesListCellViewModel, rhs: SeriesListCellViewModel) -> Bool {
    return lhs.title == rhs.title && lhs.kind == rhs.kind
  }
}
