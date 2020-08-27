//
//  BookmarkCellViewModel.swift
//  Shiori
//
//  Created by hikinit on 27/08/20.
//

import Foundation

class BookmarkCellViewModel {
  private var bookmark: Bookmark

  var name: String {
    bookmark.name!
  }

  var number: String {
    formatNumber(bookmark.number)
  }

  var kind: String {
    bookmark.kind!.capitalized
  }

  var timestamp: String {
    formatDate(bookmark.timestamp!)
  }

  var description: String {
    "\(kind) \(number)"
  }

  init(bookmark: Bookmark) {
    self.bookmark = bookmark
  }

  private func formatNumber(_ number: Float) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.decimalSeparator = "."
    formatter.minimumFractionDigits = 0
    formatter.maximumIntegerDigits = 1

    return formatter.string(from: NSNumber(value: number))!
  }

  private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMMM yyyy"

    return formatter.string(from: date)
  }
}

extension BookmarkCellViewModel: Equatable {
  static func == (lhs: BookmarkCellViewModel, rhs: BookmarkCellViewModel) -> Bool {
    return lhs.bookmark.id == rhs.bookmark.id
  }
}
