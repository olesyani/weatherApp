//
//  SearchViewController.swift
//  training
//
//  Created by Olesya Nikolaeva on 27.10.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func homeTapped(_ sender: Any) {let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "forecast")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let apiRequest = "http://api.weatherstack.com/current?access_key=eb4f48bc6224b62aafdd68ed0d7d96c9&query=\(searchBar.text!)"
        
        let urlString = apiRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        var locationName: String?
        var currentDate: String?
        var temperature: Int?
        // var sunrise: String?
        // var sunset: String?
        var windSpeed: Double?
        var humidity: Int?
        var feelslike: Int?
        var visibility: Int?
        // var chanceOfRain: Int?
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                    let localtime = location["localtime"] as! String
                    currentDate = String(localtime.prefix(10))
                }
                
                if let current = json["current"] {
                    temperature = current["temperature"] as? Int
                    windSpeed = (current["wind_speed"] as! Double) * 1000 / 60
                    humidity = current["humidity"] as? Int
                    feelslike = current["feelslike"] as? Int
                    visibility = current["visibility"] as? Int
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}

