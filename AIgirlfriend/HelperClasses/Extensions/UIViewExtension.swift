//
//  UIViewExtension.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit


extension UIView {
    
    @IBInspectable var underlineColour :UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable
    var roundCorners: Bool {
        get {
            return false
        }
        set {
            layer.cornerRadius = newValue == true ? self.frame.height / 2 : 0.0
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize{
        get{
            return layer.shadowOffset
        }
        set{
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float{
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        
        get{
            if let color = layer.shadowColor{
                return UIColor(cgColor: color)
            }
            return nil
        }
        set{
            if let color = newValue {
                layer.masksToBounds = false
                layer.shadowColor = color.cgColor
            }else{
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var underLine : CGFloat {
        get {
            return 0.0
        }
        set {
            let border = CALayer()
            let width = CGFloat(newValue)
            border.borderColor = underlineColour?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width +
                                  self.frame.size.height, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: -1, height: 1.5)
            layer.shadowOpacity = 0.8
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            return UIColor(cgColor:layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth:Float {
        get {
            return Float(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var topCorners : CGFloat {
        get {
            return 0.0
        }
        set {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBInspectable var bottomCorners : CGFloat {
        get {
            return 0.0
        }
        set {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable var rightCorners : CGFloat {
        get {
            return 0.0
        }
        set {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBInspectable var leftCorners : CGFloat {
        get {
            return 0.0
        }
        set {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = newValue
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
    }
}


@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
    
}
extension UIView {
    
    func customCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
