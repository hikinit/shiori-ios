//
//  SeriesListViewController+FlowLayout.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListFlowLayout: UICollectionViewFlowLayout {
  let margin: CGFloat = 16
  let lineSpacing: CGFloat = 16
  let cellSpacing: CGFloat = 8
  let column: CGFloat = 2
  let hwRatio: CGFloat = 3/2

  override func prepare() {
    super.prepare()

    guard let collectionView = collectionView else { return }
    let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
    let cellWidth = (availabelWidth / column) - margin

    self.itemSize = CGSize(width: cellWidth, height: cellWidth * hwRatio)
    self.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    self.sectionInsetReference = .fromSafeArea
    self.minimumLineSpacing = lineSpacing
    self.minimumInteritemSpacing = 0
  }
}
