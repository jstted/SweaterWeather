//
//  WeatherModel.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import Foundation

// MARK: - Weather
struct WeatherModel: Decodable {
    let weather: [Weather]?
    let main: Main?
    let name: String?
}

extension WeatherModel {
    
    // MARK: - Main
    struct Main: Decodable {
        let temp : Double?
    }
    
    // MARK: - Weather
    struct Weather: Decodable {
        let id: Int?
    }
}
