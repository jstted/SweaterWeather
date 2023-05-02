//
//  NetworkService.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 02.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCurrentWeather(parameters: [String: Any]?, complition: @escaping(Result<Weather?,Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getCurrentWeather(parameters: [String: Any]?, complition: @escaping (Result<Weather?, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=5b688e6220b46375c4d795fc6bc8d86d&units=metric"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                complition(.failure(error))
                return
            }
            do {
                guard let data else {
                    print("data nil")
                    return
                }
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                complition(.success(weather))
            } catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
}
