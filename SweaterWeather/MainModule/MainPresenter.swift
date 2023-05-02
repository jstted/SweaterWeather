//
//  MainPresenter.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    var weather: Weather? { get set }
    init (view: MainViewProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var weather: Weather?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
}
