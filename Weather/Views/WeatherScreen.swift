//
//  WeatherScreen.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/3/23.
//

import SwiftUI

struct WeatherScreen: View {
    @State var isReceived:Bool = true
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        
        VStack{
            
            Text(weatherService.city != nil ? weatherService.city! : "Loading...").foregroundStyle(Color.text).font(.system(size:32)).multilineTextAlignment(.center).fontWeight(.light).padding(EdgeInsets(top: 35, leading: 0, bottom: 10, trailing: 0))
            HStack{
                Text(weatherService.temperature != nil ? String(format: "%.0f",weatherService.temperature!) + "°" : "25°c").foregroundStyle(Color.text).font(.system(size:50)).multilineTextAlignment(.center).fontWeight(.light).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                VStack{
                    Image(weatherService.weather != nil ? weatherService.weather! : "Clear").resizable().scaledToFit().frame(width: 60, height: 58)
                    Text(weatherService.weather != nil ? weatherService.weather! : "Clear").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.center).fontWeight(.medium)
                }
            }.padding(.bottom, 20)
            HStack{
                Text(weatherService.weather != nil ?
                     "Highest: " + String(format: "%.0f",weatherService.tempmax!) + "°c" : "Highest: 30").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.center).fontWeight(.medium).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                Text(weatherService.weather != nil ? "Lowest: " + String(format: "%.0f",weatherService.tempmin!) + "°c": "Lowest: 30").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.center).fontWeight(.medium).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }.padding(.bottom, 20)
            Text(weatherService.weather != nil ? "Feels like: " + String(format: "%.0f",weatherService.feelslike!) + "°c": "Feels Like: 15").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.center).fontWeight(.medium).padding(.bottom, 20)
            ZStack{
                Rectangle().foregroundColor(Color.darkblue).opacity(0.5).cornerRadius(50)
                VStack{
                    Text("Advanced Weather").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.center).fontWeight(.medium).padding(.bottom, 20)
                    VStack(alignment: .leading){
                        Text(weatherService.weather != nil ? "Humidity: " + String(weatherService.humidity!) + "%": "Humidity: 30").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular)
                        Text(weatherService.weather != nil ? "Pressure: " + String(weatherService.pressure!) + "hPa": "Pressure: 30hPa").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Text(weatherService.weather != nil ? "Wind Speed: " + String(format: "%.0f",weatherService.wind_speed!) + "m/s": "Wind Speed: 30m/s").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
//                        Text(weatherService.weather != nil ? "Wind Gust: " + String(format: "%.0f",weatherService.wind_gust!) + "m/s": "Wind Gust: 30m/s").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Text(weatherService.weather != nil ? "Wind Direction: " + String(weatherService.wind_deg!) + "°": "Wind Direction: 30°").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Text(weatherService.weather != nil ? "Rainfall (last hour): " + String(format: "%.0f",weatherService.rainfall!) + "mm": "Rainfall (1 hour): 30mm").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Text(weatherService.weather != nil ? "Cloudiness: " + String(format: "%.0f",weatherService.cloudiness!) + "%": "Cloudiness: 30%").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Text(weatherService.weather != nil ? "Visibility: " + String(weatherService.visibility!) + "km": "Visibility: 30km").foregroundStyle(Color.text).font(.system(size:18)).multilineTextAlignment(.leading).fontWeight(.regular).padding(.top, 5)
                        Spacer()
                    }.multilineTextAlignment(.leading).padding(.trailing, 40).padding(.bottom, 20)
                    
                }.padding(.top, 25)
            }
            Spacer()
            Text("PaliWeather™").padding(.top, 15).foregroundStyle(Color.text).font(.system(size:25)).fontWeight(.light)
            
        }.padding(30).frame(maxWidth: .infinity).background(LinearGradient(gradient: Gradient(colors: [Color.darkblue, Color.regularblue, Color.lightblue]), startPoint: .topLeading, endPoint: .bottomTrailing)).opacity(1.0).fullScreenCover(isPresented: $isReceived)  {
            WelcomeView(isReceived: $isReceived)
        }
//        .onAppear {
//            locationManager.getLocation()
//            if locationManager.latitude != nil {
//                weatherService.getWeather(latitude: locationManager.latitude!, longitude: locationManager.longitude!)
//            }
//        }
        .onChange(of: locationManager.latitude) { newLocation in
            if newLocation != nil {
                weatherService.getWeather(latitude: locationManager.latitude!, longitude: locationManager.longitude!)
            }
        }
    }
}


struct WeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeatherScreen().environmentObject(LocationManager()).environmentObject(WeatherService())
    }
}
