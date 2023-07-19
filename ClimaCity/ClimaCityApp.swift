//
//  ClimaCityApp.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import SwiftUI

@main
struct ClimaCityApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
