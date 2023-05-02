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
    
}

//MARK: - Setup UI
extension MainViewController {
    private func setViews() {
        view.backgroundColor = .systemPink
        setupBackground()
        setupTopButton(locationButton, image: "location.circle.fill")
        setupTopButton(searchButton, image: "magnifyingglass.circle.fill")
        setupSearchTextField()
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
                                                      constant: -8)
        ])
    }
}
