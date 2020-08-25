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
