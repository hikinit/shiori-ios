//
//  SeriesListViewCell.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListCellView: UICollectionViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var bookCoverView: UIView! {
    didSet {
      let layer = bookCoverView.layer
      layer.borderWidth = 2
      layer.borderColor = UIColor.systemBackground.cgColor
      layer.cornerRadius = 8
    }
  }

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var kindLabel: UILabel!

  func configure(with viewModel: SeriesListCellViewModel) {
    titleLabel.text = viewModel.title
    kindLabel.text = viewModel.kind
  }
}
