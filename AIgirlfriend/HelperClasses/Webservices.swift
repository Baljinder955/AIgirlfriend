//
//  Webservices.swift
//  AIgirlfriend
//
//  Created by Netset on 04/08/23.
//

import Foundation
import UIKit
import SystemConfiguration
import Alamofire
import NVActivityIndicatorView

let currentTimeZone = TimeZone.current.identifier

class WebServices: NSObject {
    
    class func headers() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Authorization" : "\(DataManager.accessToken)"]
        return headers
    }
    
    class func hheaders() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Content-Type": "application/json","Authorization" : "\(DataManager.accessToken)"]
        return headers
    }
    
    
    class func getRequest(url:String,viewController : UIViewController,view:UIView,shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil, completionBlock: @escaping ( _ responseObject: Data) -> Void) {
        //        if NetworkReachabilityManager()!.isReachable {
        //            if shouldAnimateHudd {
        //                DispatchQueue.main.async {
        //                    ActivityIndicator.sharedInstance.showActivityIndicator(view: view)
        //                }
        //            }
        debugPrint("url is ====================== \(url)")
        debugPrint("Header is =================== \(WebServices.headers())")
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: WebServices.headers()).responseJSON { ( response: DataResponse) in
            debugPrint("Api Response:- ", response.value ?? "")
            
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    if let responseData = response.data {
                        do {
                            if response.response?.statusCode == 200 {
                                debugPrint("JSON String:- ",NSString(data: responseData, encoding: String.Encoding.utf8.rawValue) ?? "")
                                completionBlock(responseData)
                            } else if response.response?.statusCode == 404 {
                                if response.value is [String:Any]{
                                    //viewController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            } else if response.response?.statusCode == 500 {
                                if response.value is [String:Any]{
                                    //viewController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            } else if response.response?.statusCode == 401 {
                                print("ERROR CODE : 401 || Session Expired Please login again")
                                
                            } else if response.response?.statusCode == 400 {
                                if let dict = response.value as? [String:Any]{
                                    if dict["message"] as? String ?? "" == "Admin has deleted this chat group." {
                                        let jsonData = try? JSONSerialization.data(withJSONObject:dict)
                                        completionBlock(jsonData!)
                                    } else {
                                        //viewController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                    }
                                }
                            }
                        }
                    } else {
                        print(response.error?.localizedDescription ?? "")
                    }
                case .failure(let error):
                    let alertController = UIAlertController(title: Appinfo.appName, message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    alertController.view.tintColor = .black
                    UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        //        } else {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        ////                if refreshControl != nil {
        ////                    refreshControl?.endRefreshing()
        //
        //
        //                }
        //            }
        //        }
    }
    
    class func postRequest(url:String,VwController : UIViewController,view:UIView,param:[String:Any],method : HTTPMethod,shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil, completionBlock: @escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            //            if shouldAnimateHudd {
            //                ActivityIndicator.sharedInstance.showActivityIndicatorpost(view: view)
            //            }
            print("url is ====================== \(url)")
            print("Header is =================== \(WebServices.hheaders())")
            print("param is ==================== \(param)")
            AF.request(url, method : method, parameters : param, encoding : JSONEncoding.default , headers : WebServices.hheaders()).responseJSON { (response:DataResponse) in
                debugPrint("JSON", response.value as? NSDictionary ?? [:])
                //                if shouldAnimateHudd {
                //                    ActivityIndicator.sharedInstance.hideActivityIndicator()
                //                }
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
                switch(response.result) {
                case .success:
                    if let responseData = response.data {
                        do {
                            if (response.response?.statusCode == 200) || (response.response?.statusCode == 201) {
                                completionBlock(responseData)
                            } else if response.response?.statusCode == 404 {
                                if response.value is [String:Any]{
                                    //                                    VwController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            } else if response.response?.statusCode == 401 {
                                let alertController = UIAlertController(title: Appinfo.appName, message: "Session Expired .Please Login again", preferredStyle: .alert)
                                alertController.view.tintColor = .black
                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                    //                                    DataManager.accessToken = ""
                                }))
                                UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                            } else if response.response?.statusCode == 400 {
                                if response.value is [String:Any]{
                                    //                                    VwController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            }
                        }
                    } else {
                        let alertController = UIAlertController(title: Appinfo.appName, message:response.error?.localizedDescription, preferredStyle: .alert)
                        alertController.view.tintColor = .black
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                        }))
                        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    let alertController = UIAlertController(title:Appinfo.appName, message:error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    alertController.view.tintColor = .black
                    UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    class func postHeaderRequest(url:String,VwController : UIViewController,view:UIView,param:[String:Any],method : HTTPMethod,shouldAnimateHudd:Bool,refreshControl:UIRefreshControl? = nil, completionBlock: @escaping ( _ responseObject: Data) -> Void) {
        if (InternetReachability.sharedInstance.isInternetAvailable()) {
            //            if shouldAnimateHudd {
            //                ActivityIndicator.sharedInstance.showActivityIndicatorpost(view: view)
            //            }
            print("url is ====================== \(url)")
            print("Header is =================== \(WebServices.headers())")
            print("param is ==================== \(param)")
            AF.request(url, method : method, parameters : param, encoding : JSONEncoding.default , headers : WebServices.headers()).responseJSON { (response:DataResponse) in
                debugPrint("JSON", response.value as? NSDictionary ?? [:])
                //                if shouldAnimateHudd {
                //                    ActivityIndicator.sharedInstance.hideActivityIndicator()
                //                }
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
                switch(response.result) {
                case .success:
                    if let responseData = response.data {
                        do {
                            if response.response?.statusCode == 200 {
                                completionBlock(responseData)
                            } else if response.response?.statusCode == 404 {
                                if response.value is [String:Any]{
                                    //                                    VwController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            } else if response.response?.statusCode == 401 {
                                let alertController = UIAlertController(title: Appinfo.appName, message: "Session Expired .Please Login again", preferredStyle: .alert)
                                alertController.view.tintColor = .black
                                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                    DataManager.accessToken = ""
                                }))
                                UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                            } else if response.response?.statusCode == 400 {
                                if response.value is [String:Any]{
                                    //                                                                        VwController.showToast(message: dict["message"] as? String ?? "", font: UIFont.boldSystemFont(ofSize: 17.0))
                                }
                            }
                        }
                    } else {
                        let alertController = UIAlertController(title: Appinfo.appName, message: response.error?.localizedDescription, preferredStyle: .alert)
                        alertController.view.tintColor = .black
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                        }))
                        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: Appinfo.appName, message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                    }))
                    alertController.view.tintColor = .black
                    UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    class func putRequest(url: String, viewController: UIViewController, view: UIView, parameters: [String: Any], shouldAnimateHUD: Bool, refreshControl: UIRefreshControl? = nil, completionBlock: @escaping (_ responseObject: Data) -> Void) {
        if InternetReachability.sharedInstance.isInternetAvailable() {
            if shouldAnimateHUD {
            }
            
            print("URL is ====================== \(url)")
            print("Headers are =================== \(WebServices.headers())")
            print("Parameters are ==================== \(parameters)")
            
            AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: WebServices.headers()).responseData { response in
                
                debugPrint("JSON", response.value as? NSDictionary as Any)
                debugPrint("Response Data:", response.data as Any)
                
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
                
                switch response.result {
                case .success:
                    if let responseData = response.data {
                        
                        if response.response?.statusCode == 200 {
                            completionBlock(responseData)
                        } else if response.response?.statusCode == 404 {
                            if (try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]) != nil {
                            }
                        } else if response.response?.statusCode == 401 {
                            let alertController = UIAlertController(title: Appinfo.appName, message: "Session Expired .Please Login again", preferredStyle: .alert)
                            alertController.view.tintColor = .black
                            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                                DataManager.accessToken = ""
                            }))
                            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                        } else if response.response?.statusCode == 400 {
                            if (try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]) != nil {
                            }
                        }
                    } else {
                        let alertController = UIAlertController(title: Appinfo.appName, message: response.error?.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        }))
                        alertController.view.tintColor = .black
                        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    let alertController = UIAlertController(title: Appinfo.appName, message: error.localizedDescription, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    }))
                    alertController.view.tintColor = .black
                    UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if refreshControl != nil {
                    refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    
}
