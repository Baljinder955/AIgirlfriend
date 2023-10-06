//
//  HomeVCExt.swift
//  AIgirlfriend
//
//  Created by netset on 07/07/23.
//

import Foundation
import UIKit

extension HomeVC: HomeDelegates {
    
    //MARK: - Navigate to ProfileVC
    func gotoProfileVC() {
        let viewController = getStoryboard(.main).instantiateViewController(withIdentifier: ViewControllers.profileVC) as! ProfileVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func callApi() {
        if InternetReachability.sharedInstance.isInternetAvailable() {
            objHomeVM.callApiForHomeData(vc: self) {
                self.vwProperties.collectionView.reloadData()
            }
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
            vc.callbackTryAgainBtn = {
                debugPrint("call back is working properly")
                self.callApi()
            }
            self.present(vc, animated: true)
            debugPrint("no internet")
        }
    }
}
