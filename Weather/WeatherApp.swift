//
//  WeatherApp.swift
//  Weather
//
//  Created by Siddhant Paliwal on 7/3/23.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherScreen().environmentObject(LocationManager()).environmentObject(WeatherService())
        }
    }
}
