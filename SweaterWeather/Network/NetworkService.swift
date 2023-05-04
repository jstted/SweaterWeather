//
//  NetworkService.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 02.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCurrentWeather(queryItems: [URLQueryItem]?,
                           complition: @escaping(Result<WeatherModel?,Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    let decoder = JSONDecoder()
    
    func getCurrentWeather(queryItems: [URLQueryItem]?,
                           complition: @escaping (Result<WeatherModel?, Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                complition(.failure(error))
                return
            }
            do {
                guard let data else { return }
                let weather = try self.decoder.decode(WeatherModel.self, from: data)
                complition(.success(weather))
            } catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
}
