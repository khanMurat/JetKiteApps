//
//  ApiManager.swift
//  task4_app
//
//  Created by Murat on 30.08.2023.
//
import Foundation
import Alamofire

class ApiManager{
    
    static func fetchWeather(latitude:Double,longitude:Double,completion : @escaping (Result<WeatherModel,Error>) -> Void){
            
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=a99178578bf98e8e6f305d08df74a477&units=metric"
            
            AF.request(urlString).response { response in
                
                switch response.result {
                    
                case .success(let data):
                    
                    guard let data = data else {return}
                    
                    do{
                        let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completion(.success(decodedData))
                    }catch{
                        print("Error decoding: \(error)")
                          print(error.localizedDescription)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
