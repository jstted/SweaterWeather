//
//  MainPresenter.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import Foundation
import CoreLocation

protocol MainViewProtocol: AnyObject {
    func succes(_ weather: WeatherModel)
    func failure(_ error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    var weather: WeatherModel? { get set }
    init (view: MainViewProtocol,
          networkService: NetworkServiceProtocol,
          locationManager: LocationManager)
    func getWeatherBy(city: String)
    func getWeatherByCurrentLocation()
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var weather: WeatherModel?
    let networkService: NetworkServiceProtocol!
    let locationManager: LocationManager!
    
    required init(view: MainViewProtocol,
                  networkService: NetworkServiceProtocol,
                  locationManager: LocationManager) {
        self.view = view
        self.networkService = networkService
        self.locationManager = locationManager
//        getWeatherBy(city: "Moscow")
        getWeatherByCurrentLocation()
    }
    
    func getWeatherBy(city: String) {
        networkService.getCurrentWeather(queryItems: [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: APIKey.get.rawValue),
            URLQueryItem(name: "units", value: "metric")
        ]) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    guard let weather else { return }
                    self.weather = weather
                    print(weather)
                    self.view?.succes(weather)
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    func getWeatherByCurrentLocation() {
        networkService.getCurrentWeather(queryItems: [
            URLQueryItem(name: "lat", value: "\(locationManager.coordinate.latitude)"),
            URLQueryItem(name: "lon", value: "\(locationManager.coordinate.longitude)"),
            URLQueryItem(name: "appid", value: APIKey.get.rawValue),
            URLQueryItem(name: "units", value: "metric")
        ]) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    guard let weather else { return }
                    self.weather = weather
                    print(weather)
                    self.view?.succes(weather)
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
        }
    }
    
    func setIconToGlyph() -> String {
        guard let condition = weather?.weather?.first?.id else {
            return "antenna.radiowaves.left.and.right.slash"
        }
        switch condition {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
}
