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

  @IBAction func cancelDidTap(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }

  @IBAction func saveDidTap(_ sender: UIBarButtonItem) {}

  var series: Series!
  var viewModel: SeriesFormViewModel! {
    didSet {
      setupUI()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    viewModel.viewDidLoad()
  }

  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack())
    viewModel = SeriesFormViewModel(
      library: library,
      series: series
    )
  }

  private func setupUI() {
    titleField.text = viewModel.title
    kindField.text = viewModel.kind
    statusField.text = viewModel.status
    websiteField.text = viewModel.website

    createPickerView(textField: kindField, item: viewModel.kindOptions)
    createPickerView(textField: statusField, item: viewModel.statusOptions)
  }

  private func createPickerView(textField: UITextField, item: [String]) {
    let didSelect = { textField.text = $0 }
    let dataSource = viewModel.createPickerDataSource(item: item, didSelect: didSelect)
    textField.createPickerView(dataSource: dataSource)
  }
}

