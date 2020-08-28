//
//  BookmarkEmptyView.swift
//  Shiori
//
//  Created by hikinit on 28/08/20.
//

import UIKit

class BookmarkEmptyView: UIView {
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
      containerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      containerView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      containerView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      containerView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
    ])
  }
}
