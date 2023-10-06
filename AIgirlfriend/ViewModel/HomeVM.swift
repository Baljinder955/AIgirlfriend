//
//  HomeVM.swift
//  AIgirlfriend
//
//  Created by netset on 12/07/23.
//

import Foundation
import UIKit

class HomeVM {
    
    //MARK: - Variable Declaration
    
    var homeBaseData:[HomeBaseModel]?
    
    //MARK: - Get UserList API Method
    func callApiForHomeData(vc:UIViewController, completion:@escaping ()->()){
        WebServices.getRequest(url: "https://onlyfantasy-ai.ecomempire.in/api/v1/get-available-characters", viewController: vc, view: vc.view, shouldAnimateHudd: false) { responseObject in
            do {
                let decoder = JSONDecoder()
                let apiData = try decoder.decode([HomeBaseModel].self, from: responseObject)
                self.homeBaseData = apiData
                print("Decoded API Data:", apiData)
                completion()
            } catch {
                print("Decoding Error:", error)
            }
        }
    }
}
