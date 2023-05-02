//
//  MainViewController.swift
//  SweaterWeather
//
//  Created by Mikhail Tedeev on 01.05.2023.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - UI
    private var backgroundImageView = UIImageView()
    private var locationButton = UIButton()
    private var searchButton = UIButton()
    private var searchTextField = UITextField()
    private var weatherGlyphImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var cityLabel = UILabel()
    
    //MARK: - Property
    var presenter: MainPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setLayouts()
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
}

//MARK: - Setup UI
extension MainViewController {
    private func setViews() {
        view.backgroundColor = .systemPink
        setupBackground()
    }
    
    private func setupBackground() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
    }
}

//MARK: - Layout
extension MainViewController {
    private func setLayouts() {
        addSubviewsAndOffMask()
        setConstraints()
    }
    
    private func addSubviewsAndOffMask() {
        let subviewsArray: [UIView] = [locationButton,
                                       searchButton,
                                       searchTextField,
                                       weatherGlyphImageView,
                                       temperatureLabel,
                                       cityLabel,]
        subviewsArray.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
