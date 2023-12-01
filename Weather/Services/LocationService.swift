//
//  LocationService.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/19/23.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var latitude:Double?
    @Published var longitude:Double?

    var currentLocation: CLLocation?

    override init() {
    
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func getLocation() {
            locationManager.startUpdatingLocation()
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            //for debugging
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle error
        print("Failed to get user's location: \(error.localizedDescription)")
    }
}

