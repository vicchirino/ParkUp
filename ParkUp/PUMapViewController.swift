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
        
        var parksArray: [NSDictionary] = []
        
        
        PUClient.fetchParks(nil, nil, nil) { (parks, error) -> (Void) in
            guard let array = parks else {
                return
            }
            parksArray = array
            for park in parksArray {
                let parkDTO = Parking()
                parkDTO.createParkingWithDic(park)
                let coord = CLLocationCoordinate2DMake(parkDTO.latitude!, parkDTO.longitud!);
                let pinAnnotation = PinAnnotation()
                pinAnnotation.park = parkDTO
                pinAnnotation.setCoordinate(coord)
                pinAnnotation.title = parkDTO.street
                self.mapView.addAnnotation(pinAnnotation)
            }
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
        if let pinAnnotation = annotation as? PinAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")

            if let park = pinAnnotation.park,
                let available = park.available where available == true {
                pinAnnotationView.pinColor = .Green
            } else {
                pinAnnotationView.pinColor = .Red
            }            
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
