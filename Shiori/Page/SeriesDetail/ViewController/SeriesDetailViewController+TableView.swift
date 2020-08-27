//
//  SeriesDetailViewController+TableView.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

extension SeriesDetailViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
            withIdentifier: viewModel.cellId,
            for: indexPath) as? BookmarkCellView else {
      return UITableViewCell()
    }

    cell.configure(with: viewModel.cellViewModelAtIndexPath(indexPath))

    return cell
  }
}
