//
//  WeatherViewModel.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import Foundation
import SwiftUI


class WeatherViewModel: ObservableObject {
    @Published var weatherObject: WeatherModel = WeatherModel.MOCK_DATA
    
    init() {
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        NetworkManager.shared.fetchWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherObject = weather
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }//Dispatch
        }
    }
    
    func fetchWeather(city: String) {
        NetworkManager.shared.fetchWeather(city: city) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherObject = weather
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }//Dispatch
        }
    }
    
    
}
