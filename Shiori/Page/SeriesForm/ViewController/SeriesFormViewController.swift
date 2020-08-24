//
//  SeriesFormViewController.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

class SeriesFormViewController: UITableViewController, ViewControllerWithStoryboard {
  // MARK: - Views
  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var kindField: UITextField!
  @IBOutlet weak var statusField: UITextField!
  @IBOutlet weak var websiteField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

