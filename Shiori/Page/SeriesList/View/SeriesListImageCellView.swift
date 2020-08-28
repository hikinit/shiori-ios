//
//  SeriesListImageCellView.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

class SeriesListImageCellView: UICollectionViewCell {
  @IBOutlet weak var coverImageView: UIImageView! {
    didSet {
      let layer = coverImageView.layer
      layer.cornerRadius = 8
    }
  }

  func configure(with viewModel: SeriesListCellViewModel) {
    if let cover = viewModel.cover {
      coverImageView.image = UIImage(data: cover)
    }
  }
}
