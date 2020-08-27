//
//  SeriesDetailHeaderView.swift
//  Shiori
//
//  Created by hikinit on 26/08/20.
//

import UIKit

class SeriesDetailHeaderView: UIView {
  // MARK: - View
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var coverImageView: UIImageView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var kindLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var websiteButton: UIButton!
  @IBOutlet weak var detailStackView: UIStackView!


  // MARK: - Initializer
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

    detailStackView.setCustomSpacing(16, after: titleLabel)
  }


  // MARK: - Setup Model
  func setup(with model: SeriesListCellViewModel) {
    titleLabel.text = model.title
    kindLabel.text = model.kind
    statusLabel.text = model.status
  }

  // MARK: - Constraint
  private func setConstraint() {
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: headerView.topAnchor),
      trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
      leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
      bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
    ])
  }
}
