//
//  WeatherViewController.swift
//  training
//
//  Created by Olesya Nikolaeva on 10.10.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import UIKit


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var astroStack: UIStackView!
    @IBOutlet weak var currentCharacterStack: UIStackView!
    @IBOutlet weak var characteristicsStack: UIStackView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var snowLabel: UILabel!
    
    
    var currentWeather: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateLabel.textDropShadow()
        self.cityLabel.textDropShadow()
        self.temperatureLabel.textDropShadow()
        
        self.astroStack.addBackground(bgColor: .systemGray5, borderColor: .systemGray3, borderWidth: 3.0, radiusSize: 10.0)
        
        self.currentCharacterStack.addBackground(bgColor: .systemGray5, borderColor: .systemGray3, borderWidth: 3.0, radiusSize: 10.0)
        
        self.characteristicsStack.addBackground(bgColor: .systemGray5, borderColor: .systemGray3, borderWidth: 3.0, radiusSize: 10.0)
        
        currentWeather = CurrentWeather()
        currentWeather.downloadCurrentWeather {
            self.updateUI()
        }
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "search")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func updateUI() {
        dateLabel.text = currentWeather.date
        cityLabel.text = currentWeather.city
        temperatureLabel.text = currentWeather.temp
        windSpeedLabel.text = currentWeather.speed
        humidityLabel.text = currentWeather.humidity
        feelsLikeLabel.text = currentWeather.feelslike
        visibilityLabel.text = currentWeather.visibility
    }
    
}

