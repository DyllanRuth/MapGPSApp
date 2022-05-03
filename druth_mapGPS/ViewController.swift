//
//  ViewController.swift
//  druth_mapGPS
//
//  Created by STUDENT-SP22 on 4/19/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate { // Delegate provides library of functions so you dont have to create from scratch

    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var mapSwitch: UISwitch!
    @IBOutlet weak var zoomSlider: UISlider!
    
    let myannotation = MKPointAnnotation()
    let locationmanager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Default values
        // Set up Map View
        myMap.delegate = self
        myMap.mapType = .hybrid
        myMap.isZoomEnabled = true
        myMap.isScrollEnabled = true
        // Set up default map region
        myMap.addAnnotation(myannotation)
        let tmpRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.092540, longitude: -95.990437), latitudinalMeters: 500, longitudinalMeters: 500)
        myMap.setRegion(tmpRegion, animated: true)
        // Set up the switch
        mapSwitch.setOn(true, animated: true)
        // Set up the Slider
        zoomSlider.maximumValue = 3.0
        zoomSlider.minimumValue = 0.0
        zoomSlider.setValue(1.05, animated: true)
        
        locationmanager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest
            locationmanager.startUpdatingLocation()
    }
    
}
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let locvalue = manager.location!.coordinate
        let mynewloc = CLLocationCoordinate2DMake(locvalue.latitude, locvalue.longitude)
        myMap.setCenter(mynewloc, animated: true)
        myannotation.coordinate = mynewloc
    }
    
    
    @IBAction func SwitchMap(_ sender: Any) {
        if mapSwitch.isOn{
            myMap.mapType = .hybrid
        } else {
            myMap.mapType = .standard
        }
    }
    
    @IBAction func zoomMap(_ sender: Any) {
        let miles = Double(zoomSlider.value)
        let delta = miles / 69.0
        
        var currentRegion = myMap.region
        currentRegion.span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        myMap.region = currentRegion
        
    }
}

