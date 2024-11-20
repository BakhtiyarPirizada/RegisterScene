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
extension UIView {
    func addViews(view:[UIView]){
        view.forEach {self.addSubview($0)}
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
extension UICollectionViewCell {
    func gestureRecognizer(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
}



extension String {
    static func generateRandomCardNumber(isVisa: Bool) -> String {
        let startDigit = isVisa ? "4" : "5"
        var cardNumber = startDigit
        for _ in 1..<16 {
            let randomDigit = Int.random(in: 0...9)
            cardNumber += "\(randomDigit)"
        }
        return cardNumber
    }
}


extension String {
    static func generateCardExpiryDate() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        if let expiryDate = calendar.date(byAdding: .year, value: 3, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/yy"
            return dateFormatter.string(from: expiryDate)
        }
        return "Invalid Date"
    }
}


extension String {
    static func generateRandomCVV () -> String {
        return String(Int.random(in: 100...999))
    }
}

extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


extension String {
    
    func isValidName() -> Bool {
        let nameRegex = "^[A-Za-z]{3,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    
    
    func isValidLastname() -> Bool {
        let nameRegex = "^[A-Za-z]{3,}$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    
    func isValidFinCode() -> Bool {
           let finCodeRegex = "^[A-Z0-9]{7}$"
           let finCodePredicate = NSPredicate(format: "SELF MATCHES %@", finCodeRegex)
           return finCodePredicate.evaluate(with: self)
       }
    
  
        func isValidPhoneNumber() -> Bool {
            let phoneRegex = "^(99450|99451|99410|99455|99499|99470|99477)[0-9]{7}$"
            let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phonePredicate.evaluate(with: self)
        }
    
        func isValidPass() -> Bool {
            return self.count >= 8
    }
}

extension UILabel {
    func setLeftPaddingForLabel(padding: CGFloat) {
            let paddingString = String(repeating: " ", count: Int(padding))  
            if let currentText = self.text {
                let fullString = paddingString + currentText
                self.text = fullString
            }
        }
    }

    


extension UIButton {
    func setUnderlinedTitle(_ title: String, color: UIColor = .systemBlue) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: color
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}



extension UITextField {
    func setPlaceholder(text: String, color: UIColor, alpha: CGFloat = 1) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.withAlphaComponent(alpha)
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}



