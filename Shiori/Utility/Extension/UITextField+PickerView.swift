//
//  UITextField+PickerView.swift
//  Shiori
//
//  Created by hikinit on 24/08/20.
//

import UIKit

extension UITextField {
  func createPickerView(dataSource: PickerDataSource){
    let pickerView = UIPickerView()
    pickerView.dataSource = dataSource
    pickerView.delegate = dataSource

    self.inputView = pickerView
    self.inputAccessoryView = makePickerToolbar()
  }

  fileprivate func makePickerToolbar() -> UIToolbar {
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
    let items = [
      UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
      UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss))
    ]

    toolbar.setItems(items, animated: false)

    return toolbar
  }

  @objc fileprivate func dismiss() {
    resignFirstResponder()
  }
}

class PickerDataSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  var item: [String]
  var didSelect: (String) -> ()

  init(item: [String], didSelect: @escaping (String) -> ()) {
    self.item = item
    self.didSelect = didSelect
  }

  // Data Source
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return item.count
  }

  // Delegate
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return item[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    didSelect(item[row])
  }
}
