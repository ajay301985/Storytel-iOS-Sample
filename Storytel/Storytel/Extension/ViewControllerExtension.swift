//
//  ViewControllerExtension.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-19.
//

import Foundation
import UIKit

extension UIViewController {

  func displayAlertMessage(title: String? = nil, message: String? = nil) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: title ?? "Error", message: message ?? "Something went wrong", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alertController, animated: true)
    }
  }
}

