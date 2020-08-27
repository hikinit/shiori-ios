//
//  SeriesDetailViewController+AddBookmark.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

extension SeriesDetailViewController {
  func addBookmark() {
    let kinds = Bookmark.Kind.allCases.map { $0.rawValue.capitalized }

    let alert = AlertBuilder(style: .alert, cancel: false)
      .setTitle("Add Bookmark")
      .addTextField { [weak self] textField in
        textField.placeholder = "Select bookmark kind"

        let kindPickerDataSource = PickerDataSource(item: kinds){
          textField.text = $0
        }
        self?.kindPickerDataSource = kindPickerDataSource

        textField.createPickerView(dataSource: kindPickerDataSource)
      }
      .addTextField {
        $0.placeholder = "Number"
        $0.keyboardType = .decimalPad
      }
      .build()

    alert.addAction(UIAlertAction(title: "Save", style: .default){ _ in
      guard let tf = alert.textFields,
            let kind = tf[0].text,
            let numberString = tf[1].text,
            let number = Float(numberString)
      else { return }

      self.viewModel.addNewBookmark(kind: kind, number: number)
    })

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(alert, animated: true)
  }
}
