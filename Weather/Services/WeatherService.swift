import Foundation
struct WeatherData: Decodable {
    struct Main: Decodable {
        let feels_like: Double
        let humidity: Int
        let pressure: Int
        let temp: Double
        let temp_max: Double
        let temp_min: Double
    }

    struct Weather: Decodable {
        let description: String
        let icon: String
        let id: Int
        let main: String
    }
    struct Wind: Decodable{
        let speed : Double
        let deg : Int
//        let gust :Double
    }
    struct Clouds : Decodable{
        let all : Double
    }
    struct Rain : Decodable{
        let oneHour: Double
            
            enum CodingKeys: String, CodingKey {
                case oneHour = "1h"
            }
    }
    let main: Main
    let name: String
    let weather: [Weather]
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let rain: Rain?
}

class WeatherService:ObservableObject {
    @Published var successfulRetrieve: Bool?
    public var temperature: Double?
    public var weather:String?
    public var city:String?
    public var tempmax: Double?
    public var tempmin: Double?
    public var feelslike: Double?
    public var humidity: Int?
    public var pressure: Int?
    public var wind_speed: Double?
    public var wind_deg: Int?
    public var wind_gust: Double?
    public var rainfall: Double?
    public var cloudiness: Double?
    public var visibility: Int?



    init(){
    }
    func getWeather(latitude: Double, longitude: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=f69429a29ca4a25623f725e714b1944a&units=metric") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        self.successfulRetrieve = true
                        self.temperature = round(weatherData.main.temp)
                        self.weather = weatherData.weather.first?.main
                        self.city = weatherData.name
                        self.tempmax = round(weatherData.main.temp_max)
                        self.tempmin = round(weatherData.main.temp_min)
                        self.feelslike = round(weatherData.main.feels_like)
                        self.humidity = weatherData.main.humidity
                        self.pressure = weatherData.main.pressure
                        self.wind_speed = round(weatherData.wind.speed)
//                        self.wind_gust = round(weatherData.wind.gust)
                        self.wind_deg = weatherData.wind.deg
                        self.rainfall = round(weatherData.rain?.oneHour ?? 0)
                        self.cloudiness = round(weatherData.clouds.all)
                        self.visibility = weatherData.visibility/1000
                    }
                    print(weatherData.main)  // print main items
                    print(weatherData.name)  // print name
                    print(weatherData.weather)  // print weather items
                    print(weatherData.main.humidity)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else {
                self.successfulRetrieve = false
                print("Failed to fetch data or received incorrect status code")
            }
        }
        task.resume()
    }
}


