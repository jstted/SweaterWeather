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
    private var locationButton = UIButton(type: .system)
    private var searchButton = UIButton(type: .system)
    private var searchTextField = UITextField()
    private var weatherGlyphImageView = UIImageView()
    private var temperatureLabel = UILabel()
    private var cityLabel = UILabel()
    
    //MARK: - Property
    var presenter: MainPresenter?
    
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setLayouts()
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func succes(_ weather: Weather) {
        
        DispatchQueue.main.async {
            self.weatherGlyphImageView.image = UIImage(
                systemName: self.presenter?.setIconToGlyph() ?? "antenna.radiowaves.left.and.right.slash"
            )
            if let temperature = weather.main?.temp {
                self.temperatureLabel.text = "\(Int(temperature))˚"
            }
        }
    }
    
    func failure() {
        print("no internet connection")
    }
}

//MARK: - Setup UI
extension MainViewController {
    private func setViews() {
        setupBackground()
        setupTopButton(locationButton, image: "location.circle.fill")
        setupTopButton(searchButton, image: "magnifyingglass.circle.fill")
        setupSearchTextField()
        setupLabel(temperatureLabel, fontSize: 74, text: "-˚")
        setupLabel(cityLabel, fontSize: 23, text: "")
        setupWeatherGliphImageView()
    }
    
    private func setupBackground() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setupTopButton(_ button: UIButton, image: String) {
        button.tintColor = .tintColor
        button.setImage(UIImage(systemName: image), for: .normal)
    }
    
    private func setupSearchTextField() {
        searchTextField.placeholder = "Search city"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = UIColor(named: "backgroundColor")
        searchTextField.textColor = .tintColor
    }
    
    private func setupLabel(_ label: UILabel, fontSize: CGFloat, text: String) {
        label.textColor = .tintColor
        label.font = .systemFont(ofSize: fontSize)
        label.text = text
        label.textAlignment = .center
    }
    
    private func setupWeatherGliphImageView() {//  cloud.sun.fill fill to other 
        weatherGlyphImageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        weatherGlyphImageView.tintColor = .tintColor
        weatherGlyphImageView.contentMode = .scaleAspectFit
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
        view.addSubview(backgroundImageView)
        subviewsArray.forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            //MARK: locationButton
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationButton.widthAnchor.constraint(equalToConstant: 34),
            locationButton.heightAnchor.constraint(equalToConstant: 34),
            
            //MARK: searchButton
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 34),
            searchButton.heightAnchor.constraint(equalToConstant: 34),
            
            //MARK: locationButton
            searchTextField.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor,
                                                     constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor,
                                                      constant: -8),
            
            //MARK: temperatureLabel
            temperatureLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor,
                                                  constant: 70),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor,
                                                      constant: 4),
            
            //MARK: weatherGlyphImageView
            weatherGlyphImageView.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherGlyphImageView.trailingAnchor.constraint(equalTo: view.centerXAnchor,
                                                            constant: -4),
            weatherGlyphImageView.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            weatherGlyphImageView.widthAnchor.constraint(equalTo: weatherGlyphImageView.heightAnchor),
            
            //MARK: cityLabel
            cityLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -4),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
