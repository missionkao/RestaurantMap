//
//  ViewController.swift
//  iCHEFMap
//
//  Created by Ｍission on 2016/10/20.
//  Copyright © 2016年 ichef. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import RealmSwift

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    private var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    let mapViewModel = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        let realm = try! Realm()
        let restaurants = realm.objects(Restaurant.self)
        for r in restaurants {
            let maker = GMSMarker(position: CLLocationCoordinate2DMake(r.latitude, r.longitude))
            maker.title = r.name
            maker.snippet = r.address
            maker.map = mapView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            self.mapView.isMyLocationEnabled = true
            self.mapView.settings.myLocationButton = true
        }
    }

}

