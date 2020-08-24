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

    setupView()
  }

  private func setupView() {
    kindPickerDataSource = pickerDataSourceFronEnum(enum: Series.Kind.allCases, textField: kindField)
    kindField.createPickerView(dataSource: kindPickerDataSource)

    statusPickerDataSource = pickerDataSourceFronEnum(enum: Series.Status.allCases, textField: statusField)
    statusField.createPickerView(dataSource: statusPickerDataSource)
  }

  private func pickerDataSourceFronEnum<T>(
    enum: [T],
    textField: UITextField) -> PickerDataSource where T: CaseIterable & RawRepresentable, T.RawValue == String {
    let item = T.allCases.map { $0.rawValue }
    let didSelect = { textField.text = $0 }

    return PickerDataSource(item: item, didSelect: didSelect)
  }

  // MARK: - Privates
  private var kindPickerDataSource: PickerDataSource!
  private var statusPickerDataSource: PickerDataSource!
}

