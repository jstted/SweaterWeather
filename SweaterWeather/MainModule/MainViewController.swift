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
        presenter?.locationManager.locationManager.requestWhenInUseAuthorization()
        presenter?.locationManager.locationManager.requestLocation()
        presenter?.locationManager.getLocation()
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func succes(_ weather: WeatherModel) {
        self.weatherGlyphImageView.image = UIImage(
            systemName: self.presenter?.setIconToGlyph() ?? "antenna.radiowaves.left.and.right.slash"
        )
        if let temperature = weather.main?.temp {
            self.temperatureLabel.text = "\(Int(temperature))˚"
        }
        if let city = weather.name {
            self.cityLabel.text = city
        }
    }
    
    func failure(_ error: Error) {
        print("VIEW FAILURE probably no internet connection")
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAlertButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertButton)
        present(alert, animated: true)
    }
}

//MARK: - Setup UI
extension MainViewController {
    private func setViews() {
        setupBackground()
        setupSearchTextField()
        setupLabel(temperatureLabel, fontSize: 74, text: "-˚")
        setupLabel(cityLabel, fontSize: 27, text: "")
        setupWeatherGliphImageView()
        setupTopButton(locationButton,
                       image: "location.circle.fill",
                       action: #selector(locationButtonTarget))
        setupTopButton(searchButton,
                       image: "magnifyingglass.circle.fill",
                       action: #selector(searchButtonTarget))
    }
    
    private func setupBackground() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    private func setupTopButton(_ button: UIButton, image: String, action: Selector) {
        button.tintColor = .tintColor
        button.setImage(UIImage(systemName: image), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupSearchTextField() {
        searchTextField.placeholder = "Search city"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = UIColor(named: "backgroundColor")
        searchTextField.textColor = .tintColor
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
    }
    
    private func setupLabel(_ label: UILabel, fontSize: CGFloat, text: String) {
        label.textColor = .tintColor
        label.font = .systemFont(ofSize: fontSize)
        label.text = text
        label.textAlignment = .center
    }
    
    private func setupWeatherGliphImageView() {
        weatherGlyphImageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
        weatherGlyphImageView.tintColor = .tintColor
        weatherGlyphImageView.contentMode = .scaleAspectFit
    }
}

//MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        guard let cityName = textField.text else { return false }
        presenter?.getWeatherBy(city: cityName)
        searchTextField.text = ""
        return true
    }
}

//MARK: - Target Actions
extension MainViewController {
    @objc private func searchButtonTarget(_ sender: UIButton) {
        guard let cityName = searchTextField.text else { return }
        presenter?.getWeatherBy(city: cityName)
        view.endEditing(true)
        searchTextField.text = ""
    }
    
    @objc private func locationButtonTarget(_ sender: UIButton) {
        presenter?.getWeatherByCurrentLocation()
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
                                                  constant: 90),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.centerXAnchor,
                                                      constant: 4),
            
            //MARK: weatherGlyphImageView
            weatherGlyphImageView.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherGlyphImageView.trailingAnchor.constraint(equalTo: view.centerXAnchor,
                                                            constant: -4),
            weatherGlyphImageView.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            weatherGlyphImageView.widthAnchor.constraint(equalTo: weatherGlyphImageView.heightAnchor),
            
            //MARK: cityLabel
            cityLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -8),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
