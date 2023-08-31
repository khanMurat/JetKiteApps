//
//  WeatherViewModel.swift
//  task4_app
//
//  Created by Murat on 30.08.2023.
//

import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func didUpdateWeather(_ viewModel: WeatherViewModel)
    func didFailWithError(_ error: Error)
}

class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    
    var weatherModel: WeatherModel? {
        didSet {
            delegate?.didUpdateWeather(self)
        }
    }

    var city: String {
        return weatherModel?.name ?? ""
    }

    var temperature: String {
        return String(format: "%0.1f", weatherModel?.main.temp ?? 0)
    }

    var maxTemperature: String {
        return String(format: "%0.1f", weatherModel?.main.tempMax ?? 0)
    }

    var minTemperature: String {
        return String(format: "%0.1f", weatherModel?.main.tempMin ?? 0)
    }

    var conditionName: String {
        guard let id = weatherModel?.weather.first?.id else {
            return "cloud" }
        
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        ApiManager.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let model):
                self?.weatherModel = model
            case .failure(let error):
                self?.delegate?.didFailWithError(error)
            }
        }
    }

}

