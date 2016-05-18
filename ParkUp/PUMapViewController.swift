//
//  PUMapViewController.swift
//  ParkUp
//
//  Created by Victor Gabriel Chirino on 5/11/16.
//  Copyright © 2016 Victor Gabriel Chirino. All rights reserved.
//

import UIKit
import MapKit

protocol PUMapViewControllerDelegate {
    func PUMMapViewPinPressed(annotation: PinAnnotation)
    func PUMMapViewPinDeselected()
}


class PUMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var mapFinished = false
    var delegate: PUMapViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentLocation = mapView.userLocation
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        mapView.showsUserLocation = true
        
        // todo crear muchos pines
        
        
        let park1 = Parking()
        park1.createParkingWithLocation(-34.6141563, -58.3814979, "Venezuela 920", "Victor Chirino", "5")
        park1.ownerImageThumb = "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/12715421_10153942390418875_2002400600975061259_n.jpg?oh=f03ea1b688e117b40ba0cae9812511ec&oe=57D5F0EF&__gda__=1473384842_89451f8844661ea116b41f3a6cd18a10"
        
        let park2 = Parking()
        park2.createParkingWithLocation(-34.6143839, -58.3740375, "Defensa 563", "Leandro Mora", "5")
        park2.ownerImageThumb = "https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xfp1/v/t1.0-9/12809686_10208952026018965_8410965950898150366_n.jpg?oh=b25135353c45a3fcde8f91684f917719&oe=57E4230E&__gda__=1469900395_8e8f2226bd5699ebc0aefe1f66317e32"

        let park3 = Parking()
        park3.createParkingWithLocation(-34.6151466, -58.3764757, "Peru 624", "Julian Larralde", "4")
        park3.ownerImageThumb = "https://scontent-gru2-1.xx.fbcdn.net/v/t1.0-9/12002894_10207496134379926_4730508451595333112_n.jpg?oh=a35d7bc92b24d3c5f7f40421916a0dd9&oe=57E100C9"

        let park4 = Parking()
        park4.createParkingWithLocation(-34.6137027, -58.3756093, "Venezuela 509", "Eloy Kramar", "3")
        park4.ownerImageThumb = ""

        let parksArray = [park1,park2,park3,park4]

        for park in parksArray {
            let coord = CLLocationCoordinate2DMake(park.latitude!, park.longitud!);
            let pinAnnotation = PinAnnotation()
            pinAnnotation.park = park
            pinAnnotation.setCoordinate(coord)
            pinAnnotation.title = park.street
            self.mapView.addAnnotation(pinAnnotation)
        }
          
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        if let location: CLLocation = locations[0] where !self.mapFinished {
            let latitude:CLLocationDegrees = location.coordinate.latitude
            
            let longitude:CLLocationDegrees = location.coordinate.longitude
            
            let latDelta:CLLocationDegrees = 0.05
            
            let lonDelta:CLLocationDegrees = 0.05
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        self.mapFinished = true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is PinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinColor = .Green
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            let deleteButton = UIButton(type: .Custom)
            deleteButton.setImage(UIImage(named: "logo"), forState: .Normal)
            deleteButton.frame.size.width = 44
            deleteButton.frame.size.height = 44
            pinAnnotationView.leftCalloutAccessoryView = deleteButton
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation: PinAnnotation = view.annotation as? PinAnnotation {
            self.delegate?.PUMMapViewPinPressed(annotation)
        }
    }
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        self.delegate?.PUMMapViewPinDeselected()
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
