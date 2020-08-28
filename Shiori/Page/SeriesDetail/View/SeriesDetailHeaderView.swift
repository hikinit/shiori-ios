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
  @IBOutlet weak var coverImageActivityView: UIActivityIndicatorView!

  @IBAction func websiteButtonDidTap(_ sender: UIButton) {
    goToWebsite()
  }

  // MARK: - Properties
  private var websiteURL: URL?


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
    coverImageView.layer.cornerRadius = 8
  }


  // MARK: - Setup Model
  func setup(with model: SeriesListCellViewModel) {
    titleLabel.text = model.title
    kindLabel.text = model.kind
    statusLabel.text = model.status

    if model.hasWebsite {
      websiteButton.isHidden = false
      websiteURL = model.websiteURL
    }

    if let coverData = model.cover {
      coverImageView.image = UIImage(data: coverData)
    } else {
      coverImageView.image = UIImage(imageLiteralResourceName: "cover-unavailable")
    }

    backgroundImageView.image = coverImageView.image
  }
  

  private func goToWebsite() {
    guard let url = websiteURL,
          UIApplication.shared.canOpenURL(url) else { return }

    UIApplication.shared.open(url)
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
