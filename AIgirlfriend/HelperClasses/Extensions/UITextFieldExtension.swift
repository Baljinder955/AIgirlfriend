//
//  UITextFieldExtension.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit

extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            paddingView.isUserInteractionEnabled = false
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            paddingView.isUserInteractionEnabled = false
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField {
    
    func goToNextTextFeild(nextTextFeild:UITextField) {
        self.resignFirstResponder()
        nextTextFeild.becomeFirstResponder()
    }
    
    var isBlank : Bool {
        return (self.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!
    }
    
}
