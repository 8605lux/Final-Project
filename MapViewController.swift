//
//  MapViewController.swift
//  Best Fishing
//
//  Created by Tom on 2017/11/15.
//  Copyright © 2017年 Deitel and Associates , Inc. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let favAnnotation = MKPointAnnotation()
    let locationNodeRef = Database.database().reference().child(GlobalInstance.sharedInstance.user.uid)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        recognizer.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(recognizer)
        
        locationNodeRef.observe(.value, with: { (snapshot: DataSnapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                
                let pinLat = dictionary["latitude"]
                let pinLong = dictionary["longitude"]
                
                if pinLat != nil && pinLong != nil {
                    self.favAnnotation.coordinate = CLLocationCoordinate2D(latitude: pinLat as! Double, longitude: pinLong as! Double)
                    self.updateFavLocation()
                }
            }
        })
    }
    
    @objc func longPress(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            favAnnotation.coordinate = newCoordinates
            locationNodeRef.child("latitude").setValue(newCoordinates.latitude)
            locationNodeRef.child("longitude").setValue(newCoordinates.longitude)
            self.updateFavLocation()
        }
    }
    
    func updateFavLocation() {
        self.favAnnotation.title = "Favorite Place"
        self.favAnnotation.subtitle = GlobalInstance.sharedInstance.user.email
        self.mapView.removeAnnotation(self.favAnnotation)
        self.mapView.addAnnotation(self.favAnnotation)
    }

    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            centerMapOnLocation(location: location)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error)")
    }
    
}
