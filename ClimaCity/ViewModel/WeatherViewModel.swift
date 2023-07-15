//
//  WeatherViewModel.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import Foundation


class WeatherViewModel: ObservableObject {
    @Published var weatherObject: WeatherModel = WeatherModel.MOCK_DATA
    @Published var alertItem: AlertItem?
    
    init() { }
    
    func fetchWeather(city: String) {
        NetworkManager.shared.fetchWeather(city: city) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.weatherObject = weather
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .decodingError:
                        self.alertItem = AlertContext.decodingError
                        
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
            }//Dispatch
        }
    }
    
    
}
