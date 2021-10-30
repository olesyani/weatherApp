//
//  WeatherViewController.swift
//  training
//
//  Created by Olesya Nikolaeva on 10.10.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import UIKit


class WeatherViewController: UIViewController {
    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainStack.setCustomSpacing(90.0, after: self.dateLabel)
        
        self.dateLabel.textDropShadow()
        self.cityLabel.textDropShadow()
        //self.cityLabel.baselineAdjustment = .alignBaselines
        self.temperatureLabel.textDropShadow()
        
        self.showTemperature()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "search")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func showTemperature() {
        let apiRequest = "http://api.weatherstack.com/current?access_key=eb4f48bc6224b62aafdd68ed0d7d96c9&query=Nizhny"
            
            let urlString = apiRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            
            var locationName: String!
            var currentDate: String!
            var temperature: Int!
            // var sunrise: String?
            // var sunset: String?
            var windSpeed: Double!
            var humidity: Int!
            var feelslike: Int!
            var visibility: Int!
            // var chanceOfRain: Int?
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { [weak self] data, response, error in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                    
                    if let location = json["location"] {
                        locationName = location["name"] as? String
                        let localtime = location["localtime"] as! String
                        currentDate = String(localtime.prefix(10))
                    }
                    
                    if let current = json["current"] {
                        temperature = current["temperature"] as? Int
                        windSpeed = (current["wind_speed"] as! Double) * 1000 / 3600
                        humidity = current["humidity"] as? Int
                        feelslike = current["feelslike"] as? Int
                        visibility = current["visibility"] as? Int
                    }
                    
                    let speed = Double(round(10*windSpeed!)/10)
                    
                    // без Dispatch.mail.async программа будет работать в фоновом потоке, а не основном. Ошибка может привести к пропущенным обновлениям UI, визуальным дефектам, повреждениям данных и сбоям.
                    DispatchQueue.main.async {
                        self?.dateLabel.text = currentDate
                        self?.cityLabel.text = locationName
                        self?.temperatureLabel.text = "\(temperature!)" + " °C"
                        self?.windSpeedLabel.text = "\(speed)" + " m/s"
                        self?.humidityLabel.text = "\(humidity!)" + "%"
                        self?.feelsLikeLabel.text = "\(feelslike!)" + " °C"
                        self?.visibilityLabel.text = "\(visibility!)" + " km"
                    }
                    
                }
                catch let jsonError {
                    print(jsonError)
                }
            }.resume()
    }
}

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray5.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
    }

    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}
