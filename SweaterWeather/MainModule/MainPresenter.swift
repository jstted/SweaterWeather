//
//  MainPresenter.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func succes(_ weather: WeatherModel)
    func failure(_ error: Error)
}

protocol MainPresenterProtocol: AnyObject {
    var weather: WeatherModel? { get set }
    init (view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func getWeather(city: String)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var weather: WeatherModel?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getWeather(city: "Moscow")
    }
    
    func getWeather(city: String) {
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
                    print(error.localizedDescription)
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
