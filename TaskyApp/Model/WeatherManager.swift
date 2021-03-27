import Foundation

protocol WeatherManagerDelegate {
    func didupdateWeather(weather: weatherModel)
    func didFailwithError(error: Error)
}

struct WeatherManager {
    let apiKey = ""
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&appid=\(apiKey)&q=\(cityName)"
        performNetwork(with: urlString)
    }
    
    func performNetwork(with urlString: String) {
    
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailwithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData) {
                        self.delegate?.didupdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(weatherData: Data) -> weatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = weatherModel(cityName: name, temperature: temp, id: id)
            return weather
        } catch {
            delegate?.didFailwithError(error: error)
            return nil
        }
    }
}
