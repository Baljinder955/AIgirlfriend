//
//  CommonFunctionFile.swift
//  AIattorney
//
//  Created by netset on 03/07/23.
//

import UIKit

// MARK: Common Variables
var appDelegateObj = UIApplication.shared.delegate as! AppDelegate

// MARK: Get Storyboard
func getStoryboard(_ storyType:Storyboards) -> UIStoryboard {
    return UIStoryboard(name: storyType.rawValue, bundle: nil)
}

// MARK: - Get String From Date Method
func getStringFromDate(date: Date,needFormat: String) -> String {
    var dateStr = String()
    if needFormat != "" {
        let formatter = DateFormatter()
        formatter.dateFormat = needFormat
        let locale = Locale.current
        formatter.locale = locale
        dateStr = formatter.string(from: date)
    }
    return dateStr
}

// MARK: Get Time In String Method
func getTimeFormatInStr(getTime:String,backendFormat:String,needTimeFormat:String) -> String {
    var resultTimeInStr = String()
    if getTime != "" {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = backendFormat//"yyyy-MM-dd hh:mm a"
        let timeInStr = dateFormatter.date(from: getTime)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = needTimeFormat//"yyyy-MM-dd"
        if timeInStr != nil {
            resultTimeInStr = dateFormatter1.string(from: timeInStr!)
        }
    }
    return resultTimeInStr
}
