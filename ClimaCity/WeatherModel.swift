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