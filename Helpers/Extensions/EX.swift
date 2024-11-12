//
//  EX.swift
//  Milioner
//
//  Created by Bakhtiyar Pirizada on 16.10.24.
//

import Foundation
import UIKit



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
    func setLeftPaddingForLabel(_ amount: CGFloat) {
        let padding = UIEdgeInsets(top: 0, left: amount, bottom: 0, right: 0)
        self.drawText(in: self.bounds.inset(by: padding))
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
