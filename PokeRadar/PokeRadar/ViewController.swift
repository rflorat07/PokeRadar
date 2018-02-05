//
//  ViewController.swift
//  PokeRadar
//
//  Created by Roger Florat on 05/02/18.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import MapKit
import GeoFire
import FirebaseDatabase

class ViewController: UIViewController {
    
    // Outlet
    @IBOutlet weak var mapView: MKMapView!
    
    var geoFire : GeoFire!
    
    var mapCentered = false
    
    var geoFireRef : DatabaseReference!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.geoFireRef = Database.database().reference()
        self.geoFire = GeoFire(firebaseRef: self.geoFireRef)
        
        self.mapView.delegate = self
        self.mapView.userTrackingMode = .follow
        
        self.locationManager.delegate = self
        
        locationAuthStatus()
    }
    
    
    func createSighting(forLocation location: CLLocation, with pokemonId: Int) {
        self.geoFire.setLocation(location, forKey: "\(pokemonId)")
    }
    
    @IBAction func reportPokemon(_ sender: Any) {
    }
    
    
}

extension ViewController: MKMapViewDelegate{
    
    func centerMap(on location: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if !mapCentered {
            if let location = userLocation.location {
                centerMap(on: location)
                mapCentered = true
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView : MKAnnotationView?
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = #imageLiteral(resourceName: "character")
        }
        
        return annotationView
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
        
    }
    
}

