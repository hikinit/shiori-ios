//
//  SeriesListViewController+Delegate.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

extension SeriesListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc: SeriesDetailViewController = SeriesDetailViewController.loadFromStoryboard()
    let cell = viewModel.cellViewModelsAtIndexPath(indexPath)
    vc.series = cell.series

    navigationController?.pushViewController(vc, animated: true)
  }
}
