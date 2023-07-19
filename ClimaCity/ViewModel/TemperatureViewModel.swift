//
//  TemperatureViewModel.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 19/07/23.
//

import SwiftUI

enum TemperatureUnit: String {
    case celsius = "C"
    case fahrenheit = "F"
}

class TemperatureViewModel: ObservableObject {
    @AppStorage("temperatureUnit") var temperatureUnit: TemperatureUnit = .celsius
}
