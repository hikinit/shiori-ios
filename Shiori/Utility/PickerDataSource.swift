//
//  PickerDataSource.swift
//  Shiori
//
//  Created by hikinit on 25/08/20.
//

import Foundation
import UIKit

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
