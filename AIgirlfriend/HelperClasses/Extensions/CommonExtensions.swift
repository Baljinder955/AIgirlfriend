//
//  CommonExtensions.swift
// BaseApp
//
//  Created by netset on 09/12/22.
//
import Foundation
import UIKit
import SDWebImage

extension UIWindow {
    
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension JSONDecoder {
    func decode<T : Decodable> (model: T.Type, data: Data) -> T? {
        do {
            let myStruct = try self.decode(model, from: data)
            return myStruct
        } catch {
            return nil
        }
    }
}

extension UserDefaults {
    
    func setData<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func valueData<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

extension UIImageView {
    
    func setImageOnImageViewWithoutServer(_ urlStr: String,placeholder: UIImage) {
        self.sd_setImage(with: URL(string: urlStr), placeholderImage: placeholder, options: .highPriority, completed: nil)
    }
}
