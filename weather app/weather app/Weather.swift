//
//  Weather.swift
//  weather app
//
//  Created by oscar nunez on 9/13/21.

// Model : what our view model will use to show in the UI

import Foundation

public struct Weather {
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    // initialize a weather model
    
    init(response: APIResponse){
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
