//
//  LocationManager.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 04.05.2023.
//

import CoreLocation

protocol LocationManagerProtocol {
    var locationManager: CLLocationManager { get set }
    var coordinate: CLLocationCoordinate2D { get }
    func getLocation() -> CLLocationCoordinate2D
}

class LocationManager: NSObject, LocationManagerProtocol {
    var locationManager = CLLocationManager()
    var coordinate = CLLocationCoordinate2D()
    weak var mainModule: MainPresenterProtocol?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    
    func getLocation() -> CLLocationCoordinate2D {
        locationManager.requestLocation()
        let result = coordinate
        return result
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last?.coordinate else { return }
        print(currentLocation)
        mainModule?.getWeatherByCurrentLocation(lat: currentLocation.latitude,
                                                lon: currentLocation.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
