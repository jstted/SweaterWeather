//
//  Weather.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let coord: Coord?
    let weather: [WeatherElement]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int?
}

// MARK: - Coord
struct Coord: Decodable {
    let lon: Double?
    let lat: Double?
}

// MARK: - Main
struct Main: Decodable {
    let temp : Double?
    let feelsLike : Double?
    let tempMin : Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}

// MARK: - WeatherElement
struct WeatherElement: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double?
    let deg: Int?
}
