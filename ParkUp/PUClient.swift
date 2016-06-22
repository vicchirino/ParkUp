//
//  PUClient.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/28/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit
import Alamofire

public let PUClient = PUClientClass()

typealias parksBlock = (parks: [NSDictionary]?,error: NSError?) -> (Void)

public class PUClientClass {
    let manager: Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        return Manager(configuration: configuration)
    }()
    
    
    func fetchParks(date: NSDate?, _ hourFrom: String?, _ hourTo: String?, completion: parksBlock) {
        
        var d = NSDate()
        var hourFromToUse = ""
        var hourToToUse = ""
        if let dateToUse = date {
            d = dateToUse
        }
        
        let styler = NSDateFormatter()
        styler.dateFormat = "yyyy-MM-dd"
        let fecha = styler.stringFromDate(d)
        let hourToday = NSCalendar.currentCalendar().component(.Hour, fromDate: d)
        hourFromToUse = "\(hourToday)"
        var urlToUse = ""
        if let hf = hourFrom {
            hourFromToUse = hf
        }
        urlToUse = "http://hidden-forest-50306.herokuapp.com/api/garage?date=\(fecha)&hourFrom=\(hourFromToUse)"
        if let ht = hourTo {
            hourToToUse = ht
            urlToUse = "http://hidden-forest-50306.herokuapp.com/api/garage?date=\(fecha)&hourFrom=\(hourFromToUse)&hourTo=\(hourToToUse)"
        }

        self.manager.request(.GET, urlToUse, parameters: nil, encoding: .JSON, headers: nil).responseJSON { (response) in
            if let parksArray = response.result.value as? [NSDictionary] {
                print(parksArray)
                completion(parks: parksArray, error: response.result.error)
            }
        }
    }
    
}