//
//  Builder.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import UIKit

protocol BuilderProtocol {
    static func buildMainModule () -> UIViewController
}

final class Builder: BuilderProtocol {
    static func buildMainModule() -> UIViewController {
        let locationManager = LocationManager()
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view,
                                      networkService: networkService,
                                      locationManager: locationManager)
        locationManager.mainModule = presenter
        view.presenter = presenter
        return view
    }
}
