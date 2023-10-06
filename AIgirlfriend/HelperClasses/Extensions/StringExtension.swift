//
//  StringExtension.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit

extension String {
    
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    func removeWhiteSpace() -> String {
        let str = self.components(separatedBy: .whitespaces).joined()
        return str
    }
    
    var addingPercent:String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}
extension NSMutableAttributedString {
    //MARK:- Attributed String
    @discardableResult func attributedString(_ str1:String,color: UIColor,font:UIFont,lineHeight:CGFloat,align:String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = align == TextAlign.center ? .center : .left
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: color, NSAttributedString.Key.font: font,.paragraphStyle : paragraphStyle]
        let firstString = NSMutableAttributedString(string: str1, attributes: firstAttributes)
        append(firstString)
        return self
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attributedText = label.attributedText else { return false }
        let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
        mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: mutableStr)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
