//
//  SeriesListEmptyView.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

class SeriesListEmptyView: UIView {
  @IBOutlet weak var containerView: UIView!

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

    addSubview(containerView)

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: containerView.topAnchor),
      trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    ])
  }
}
