//
//  PinAnnotation.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/16/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import MapKit
import Foundation
import UIKit

class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    var title: String? = ""
    var subtitle: String? = ""
    var park: Parking?

    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
}