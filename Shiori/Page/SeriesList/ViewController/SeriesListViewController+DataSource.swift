//
//  SeriesListDataSource.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

extension SeriesListViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let count = viewModel.numberOfRows

    if count == 0 {
      collectionView.backgroundView = SeriesListEmptyView(frame: collectionView.bounds)
    } else {
      collectionView.backgroundView = nil
    }

    return count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellViewModel = viewModel.cellViewModelsAtIndexPath(indexPath)

    if cellViewModel.cover != nil {
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: "SeriesListImageCellView",
        for: indexPath
      ) as! SeriesListImageCellView

      cell.configure(with: cellViewModel)

      return cell
    }

    let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: viewModel.cellId,
            for: indexPath
    ) as! SeriesListCellView

    cell.configure(with: cellViewModel)

    return cell
  }

}
