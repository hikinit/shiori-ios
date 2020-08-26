//
//  SeriesListViewController+Delegate.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

extension SeriesListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Selected:", indexPath)
  }
}
