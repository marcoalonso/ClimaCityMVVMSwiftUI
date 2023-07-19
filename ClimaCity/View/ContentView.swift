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
    @State private var showConfigView = false
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 25.0) {
                    HStack(spacing: 10.0) {
                        
                        if let iconUrl = viewModel.weatherObject?.weather[0].icon {
                            let _ = print("Debug: \(iconUrl)")

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
                            .font(.system(size: 50))
                            .fontWeight(.semibold)
                        }
                    }
                    
                    if let city = viewModel.weatherObject?.name, let description = viewModel.weatherObject?.weather[0].description {
                        Text("Now in \(city) there is \(description)")
                            .font(.largeTitle)                    }
                    
                    if let humidity = viewModel.weatherObject?.main.humidity {
                        Text("Humidity \(humidity)%")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                   
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(isDarkModeOn ? .white : .black)
                .onChange(of: locationDataManager.lastLocation, perform: { newValue in
                    viewModel.fetchWeather(lat: newValue?.coordinate.latitude ?? 0.0,
                                           lon: newValue?.coordinate.longitude ?? 0.0)
                })
                .onAppear{
                    if locationDataManager.locationManager.authorizationStatus == .authorizedWhenInUse {
                        fetchWeatherByLocation()
                    }
                }
                .searchable(text: $city, prompt: "Search country")
                .onChange(of: city, perform: { newCity in
                    if city != "" && city.count > 3 {
                        viewModel.fetchWeather(city: newCity.replacingOccurrences(of: " ", with: "%20"))
                    }
                })
                .padding(.top, 30)
                .padding(.horizontal)
                
                .navigationBarItems(trailing: NavigationLink(destination: {
                    SettingsView()
                }, label: {
                    Image(systemName: "gearshape")
                }))
                .navigationBarItems(leading: Button(action: {
                    fetchWeatherByLocation()
                }, label: {
                    Image(systemName: "location.circle")
                }))
                
            .navigationBarTitle("Weather", displayMode: .inline)
            
            }//:Zstack
            .background(
                isDarkModeOn ? LinearGradient(colors: [.gray, .white], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    private func fetchWeatherByLocation(){
        viewModel.fetchWeather(lat: locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0,
                               lon: locationDataManager.locationManager.location?.coordinate.latitude ?? 0.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


