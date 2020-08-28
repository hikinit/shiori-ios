//
//  SeriesListDataSource.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

extension SeriesListViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: viewModel.cellId,
            for: indexPath) as? SeriesListCellView else {
      fatalError("Can't load \(SeriesListCellView.description())")
    }

    let cellViewModel = viewModel.cellViewModelsAtIndexPath(indexPath)
    cell.configure(with: cellViewModel)

    return cell
  }

}
