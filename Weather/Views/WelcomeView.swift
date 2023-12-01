//
//  ContentView.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/3/23.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isReceived:Bool;
    @EnvironmentObject var locationService: LocationManager;
    @EnvironmentObject var weatherService :WeatherService;
    var body: some View {
        NavigationView{
            VStack(spacing: 30.0 ){

                    Spacer();
                    
                Text("Welcome to PaliWeather").foregroundStyle(Color.text).font(.system(size:30)).bold().multilineTextAlignment(.center).padding(.bottom, 10)
                    
                Text("A beautiful weather checking interface by Siddhant Paliwal").foregroundStyle(Color.text).multilineTextAlignment(.center).padding(.bottom, 40)
                    
                    Button {
                        
                        locationService.getLocation()
                        if locationService.latitude != nil {
                            isReceived = false
                            weatherService.getWeather(latitude: locationService.latitude!, longitude: locationService.longitude!)
                        }
                        else{
                            isReceived = true
                        }
                        
                    } label: {
                        Text("Continue")
                            .padding(10).foregroundStyle(Color.white).background(Color.blue).cornerRadius(10).fontWeight(.semibold)
                    }
                    .contentShape(Rectangle())
                    Spacer();
                }.padding(10).frame(maxWidth: .infinity).background(Color.darkblue).opacity(0.9)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isReceived: .constant(false)).environmentObject( LocationManager()).environmentObject(WeatherService())
    }
}
