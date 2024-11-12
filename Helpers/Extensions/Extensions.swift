//
//  Extensions.swift
//  Milioner
//
//  Created by Bakhtiyar Pirizada on 16.10.24.
//

import Foundation
import UIKit
extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
extension UIViewController {
    func showMessage(
        title: String = "",
        message: String = "",
        actionTitle: String = "OK"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIViewController {
    func gestureRecognizer(to view: UIView, action: Selector) {
          let tapGesture = UITapGestureRecognizer(target: self, action: action)
          view.isUserInteractionEnabled = true
          view.addGestureRecognizer(tapGesture)
      }
}
