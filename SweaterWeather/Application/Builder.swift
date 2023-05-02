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
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
