//
//  WeatherModel.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import Foundation

struct WeatherModel: Decodable, Encodable {
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Main : Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
    let id: Int
}

extension WeatherModel {
    //static let MOCK_DATA: WeatherModel = WeatherModel(name: "Morelia", weather: [Weather(description: "algo de nubes", icon: "02d", id: 801)], main: Main(temp: 23.9, humidity: 68))
    static let MOCK_DATA: WeatherModel = WeatherModel(name: "", weather: [Weather(description: "", icon: "", id: 0)], main: Main(temp: 0, humidity: 0))
                                                      
}
