//
//  SeriesDetailViewController+TableView.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

extension SeriesDetailViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rows = viewModel.numberOfRows

    if rows == 0 {
      let view = BookmarkEmptyView()
      view.layoutMargins = UIEdgeInsets(top: tableView.tableHeaderView!.bounds.height, left: 0, bottom: 0, right: 0)
      tableView.backgroundView = view
      tableView.separatorStyle = .none
    } else {
      tableView.backgroundView = nil
      tableView.separatorStyle = .singleLine
    }

    return rows
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

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      viewModel.deleteBookmarkAtIndexPath(indexPath) { _ in
        tableView.reloadData()
      }
    default:
      break
    }
  }
}
