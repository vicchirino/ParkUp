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
    
    func createParkingWithLocation(latitude:CLLocationDegrees, _ longitud: CLLocationDegrees, _ street: String, _ ownerName: String, _ reputation: String) {
        self.latitude = latitude
        self.longitud = longitud
        self.street = street
        self.ownerName = ownerName
        self.reputation = reputation
    }
    
}


