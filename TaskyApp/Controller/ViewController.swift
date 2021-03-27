import UIKit

class ViewController: UIViewController {

    var weatherManager = WeatherManager()
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var conditionIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchBar.delegate = self
    }

    @IBAction func buttonSearch(_ sender: UIButton) {
        
        print(searchBar.text!)
        searchBar.endEditing(true)
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(searchBar.text!)
        searchBar.endEditing(true)

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.fetchWeather(cityName: searchBar.text!)
        searchBar.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchBar.text != "" {
            return true
        }
        else {
            searchBar.placeholder = "Please Enter Country Name"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate
extension ViewController: WeatherManagerDelegate {
    func didupdateWeather(weather: weatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionIcon.image = UIImage(systemName: weather.coditionName)
        }
    }
    func didFailwithError(error: Error) {
        print(error)
    }
}

