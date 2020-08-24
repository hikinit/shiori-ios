//
//  SeriesListViewController+FlowLayout.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

extension SeriesListViewController: UICollectionViewDelegateFlowLayout {
  struct Layout {
    static let margin: CGFloat = 16
    static let lineSpacing: CGFloat = 8
    static let cellSpacing: CGFloat = 8
    static let column: CGFloat = 2
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let collectionFrame = collectionView.frame.insetBy(dx: Layout.margin, dy: 0)

    let cellWidth = (collectionFrame.width / Layout.column) - Layout.margin / Layout.column

    return CGSize(width: cellWidth, height: cellWidth * 3/2)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Layout.lineSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {

    let margin = Layout.margin
    return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
  }
}
