//
//  HomeProperties.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.

import UIKit

//MARK: - Protocol
protocol HomeDelegates {
    func gotoProfileVC()
}

var didSelectItem:Bool = true

class HomeProperties: UIView{
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblGreetings: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variable Declaration
    var objHomeDelegate:HomeDelegates?
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let userData = UserDefaults.standard.value(forKey: "userData") as? [String:Any]
        let name = userData?["firstName"] as? String ?? "empty name"
        lblUsername.text = name
    }
    
    //MARK: - IBActions
    @IBAction func actionBtnViewProfile(_ sender: Any) {
        objHomeDelegate?.gotoProfileVC()
    }
    
    // MARK: - Greeting change According to time
    func updateGreeting() {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: Date())

            if 0..<12 ~= hour {
                // Morning (12 AM to 11:59 AM)
                lblGreetings.text = "Hii Good Morning!"
            } else if 12..<16 ~= hour {
                // Afternoon (12 PM to 4:59 PM)
                lblGreetings.text = "Hii Good Afternoon!"
            } else {
                // Evening (5 PM to 11:59 PM)
                lblGreetings.text = "Hii Good Evening!"
            }
        }

}
