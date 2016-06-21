//
//  Parking.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/18/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit
import MapKit

class Parking: NSObject {
    var latitude: CLLocationDegrees?
    var longitud: CLLocationDegrees?
    var street: String?
    var ownerName: String?
    var reputation: String?
    var ownerImageThumb: String?
    var available: Bool?
    var garage_id: String?
    
    func createParkingWithLocation(latitude:CLLocationDegrees, _ longitud: CLLocationDegrees, _ street: String, _ ownerName: String, _ reputation: String) {
        self.latitude = latitude
        self.longitud = longitud
        self.street = street
        self.ownerName = ownerName
        self.reputation = reputation
    }
    func createParkingWithDic(dic: NSDictionary) {      
        if let lat = dic["latitude"] as? Double,
            let lon = dic["longitude"] as? Double {
            self.latitude = lat
            self.longitud = lon
        }
        self.garage_id = dic["garage_id"] as? String
        self.street = dic["address"] as? String
        self.ownerName = dic["name"] as? String
        self.reputation = dic["reputation"] as? String
        self.available = dic["available"] as? Bool
        self.ownerImageThumb = dic["picture"] as? String
    }
    
}


