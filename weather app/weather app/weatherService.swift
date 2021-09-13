//
//  weatherService.swift
//  weather app
//
//  Created by oscar nunez on 9/13/21.
// this file will be responsible to get the user weather location and weather information from open weather app

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let API_KEY = "f447aa681ac772bf624cbf17aee07dea"
    // when we are able to get the weather data
    private var completionHandler: ((Weather) -> Void)?
    
    public func loadWeatherData (_ completionHandler: @escaping(Weather)-> Void) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    private func makeDataRequest (forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&unit=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard error == nil, let data = data else {return}
        }
    }
    
}

//All our API Response is outline below
// Structure of our app
struct APIResponse {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

//response for the main section API
struct APIMain: Decodable {
    let temp: Double
}

//response from the weather section API
struct APIWeather: Decodable {
    let description: String
    // IconName will be using the value of the main property from the API response
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
// end of API
}
