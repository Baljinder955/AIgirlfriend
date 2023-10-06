//
//  TableViewExtension.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: (self.bounds.size.width - 40), height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
    //static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    //static var nib: UINib? { return nil }
}
