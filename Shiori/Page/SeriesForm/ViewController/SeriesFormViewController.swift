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
  @IBOutlet weak var saveButton: UIBarButtonItem!

  @IBAction func titleFieldDidEditingChange(_ sender: UITextField) {
    updateViewModelProperties(textField: sender)
  }
  
  @IBAction func cancelDidTap(_ sender: UIBarButtonItem) {
    dismiss(animated: true)
  }

  @IBAction func saveDidTap(_ sender: UIBarButtonItem) {}

  var series: Series!
  var viewModel: SeriesFormViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
    setupView()
    viewModel.viewDidLoad()
  }

  private func setupViewModel() {
    let library = Library(coreDataStack: CoreDataStack())
    viewModel = SeriesFormViewModel(
      library: library,
      series: series
    )
  }

  private func setupView() {
    titleField.text = viewModel.title
    kindField.text = viewModel.kind
    statusField.text = viewModel.status
    websiteField.text = viewModel.website

    createPickerView(textField: kindField, item: viewModel.kindOptions)
    createPickerView(textField: statusField, item: viewModel.statusOptions)
    saveButtonToggleEnable()
  }

  private func updateViewModelProperties(textField: UITextField) {
    switch textField.tag {
      case 101: viewModel.title = textField.text
      case 102: viewModel.kind = textField.text
      case 103: viewModel.status = textField.text
      case 104: viewModel.website = textField.text
      default: break
    }

    saveButtonToggleEnable()
  }

  private func saveButtonToggleEnable() {
    saveButton.isEnabled = viewModel.saveButtonIsEnabled
  }

  private func createPickerView(textField: UITextField, item: [String]) {
    let didSelect: (String) -> () = { [weak self] in
      textField.text = $0
      self?.updateViewModelProperties(textField: textField)
    }

    let dataSource = PickerDataSource(item: item, didSelect: didSelect)

    pickerDataSources.append(dataSource)
    textField.createPickerView(dataSource: dataSource)
  }

  private var pickerDataSources = [PickerDataSource]()
}

