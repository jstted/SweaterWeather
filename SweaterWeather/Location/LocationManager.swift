//
//  LocationManager.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 04.05.2023.
//

import CoreLocation

protocol LocationManagerProtocol {
    var locationManager: CLLocationManager { get set }
    func getLocation()
}

class LocationManager: NSObject, LocationManagerProtocol {
    var locationManager = CLLocationManager()
    var coordinate = CLLocationCoordinate2D()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func getLocation(){
        print(coordinate)
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last?.coordinate else { return }
        coordinate = currentLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
