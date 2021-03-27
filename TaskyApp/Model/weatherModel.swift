import Foundation

struct weatherModel {
    let cityName: String
    let temperature: Float
    let id: Int
    
    // here i creat 2 computed property
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var coditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 600...622:
            return "cloud.rain"
        case 701...781:
            return "cloud.snow"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "clould"
        }
    }
}
