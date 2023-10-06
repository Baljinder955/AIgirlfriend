//
//  GesturesMove.swift
//  AIgirlfriend
//
//  Created by netset on 14/09/23.
//

import UIKit

class SwipeNavigationUtility:UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSwipeGestures()
    }
    
    private func setupSwipeGestures() {
         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
         swipeRight.direction = .right
         view.addGestureRecognizer(swipeRight)

//         let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//         swipeLeft.direction = .left
//         view.addGestureRecognizer(swipeLeft)
     }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            popViewController(animated: true)
        case .left:
            let nextViewController = UIViewController()
            pushViewController(nextViewController, animated: true)
        default:
            break
        }
    }
}
