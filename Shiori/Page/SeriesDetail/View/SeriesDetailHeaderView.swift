//
//  SeriesDetailHeaderView.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailHeaderView: UIView {
  @IBOutlet weak var headerView: UIView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.initView()
  }

  private func initView() {
    let nib = UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    nib.instantiate(withOwner: self, options: nil)

    addSubview(headerView)
    setConstraint()
  }

  private func setConstraint() {
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: headerView.topAnchor),
      trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
      leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
      bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
    ])
  }
}
