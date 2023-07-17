//
//  ContentView.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    @State private var city = ""
    @StateObject var locationDataManager = LocationDataManager()
    @State private var mostrarAlerta = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 25.0) {
                    HStack(spacing: 20.0) {
                        
                        if let iconUrl = viewModel.weatherObject?.weather[0].icon {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconUrl)@2x.png")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 120, height: 120)
                            .shadow(radius: 12)
                        }
                        
                        if let temp = viewModel.weatherObject?.main.temp {
                            HStack {
                                Text(String(format: "%.1f",temp))
                                Text("°C")
                            }
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        }
                    }
                    
                    if let city = viewModel.weatherObject?.name, let description = viewModel.weatherObject?.weather[0].description {
                        Text("Ahora en \(city) hay \(description)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    
                    if let humidity = viewModel.weatherObject?.main.humidity {
                        Text("Humedad \(humidity)%")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                   
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onChange(of: locationDataManager.lastLocation, perform: { newValue in
                    viewModel.fetchWeather(lat: newValue?.coordinate.latitude ?? 0.0,
                                           lon: newValue?.coordinate.longitude ?? 0.0)
                })
                .onAppear{
                    if locationDataManager.locationManager.authorizationStatus == .authorizedWhenInUse {
                        viewModel.fetchWeather(lat: locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0,
                                               lon: locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0)
                    }
                }
                .searchable(text: $city, prompt: "Buscar ciudad o pais")
                .onChange(of: city, perform: { newCity in
                    if city != "" && city.count > 3 {
                        viewModel.fetchWeather(city: newCity.replacingOccurrences(of: " ", with: "%20"))
                    }
                })
                .padding(.top, 30)
                .padding(.horizontal)
                
            .navigationBarTitle("Weather", displayMode: .inline)
            }
            .background(
                LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


