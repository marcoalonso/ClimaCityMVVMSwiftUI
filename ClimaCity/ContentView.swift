//
//  ContentView.swift
//  ClimaCity
//
//  Created by Marco Alonso Rodriguez on 14/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = WeatherViewModel()
    @State private var city = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25.0) {
                    HStack(spacing: 20.0) {
                        Image(systemName: "cloud")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        
                        HStack {
                            
                            Text("\(String(format: "%.1f", viewModel.weatherObject.main.temp))")
                            Text("°C")
                        }
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    }
                    
                    Text("Ahora en \(viewModel.weatherObject.name) hay   \(viewModel.weatherObject.weather[0].description)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    
                    Text("Humedad \(viewModel.weatherObject.main.humidity)%")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .searchable(text: $city, prompt: "Buscar ciudad o pais")
                .onChange(of: city, perform: { newCity in
                    if city != "" && city.count > 3 {
                        viewModel.fetchWeather(city: newCity.replacingOccurrences(of: " ", with: "%20"))
                    }
                })
                .padding(.top, 30)
                .padding(.horizontal)
            }
            .navigationBarTitle("Weather", displayMode: .inline)
            .navigationBarItems(trailing: Image(systemName: "location"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
