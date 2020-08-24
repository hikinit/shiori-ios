//
//  SeriesListDataSource.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesListDataSource: NSObject, UICollectionViewDataSource {
  
  private var viewModel: SeriesListViewModel

  init(viewModel: SeriesListViewModel) {
    self.viewModel = viewModel
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    cell.backgroundColor = .red
    return cell
  }

}
