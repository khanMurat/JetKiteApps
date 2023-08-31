//
//  ViewController.swift
//  task4_app
//
//  Created by Murat on 29.08.2023.
//

import UIKit
import CoreLocation

private let identifer = "identifer"

class WeatherViewController: UICollectionViewController, CLLocationManagerDelegate {
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    
    var latitude : Double?
    
    var longitude : Double?
    
    var viewModel = WeatherViewModel()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationRequest()
        
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: identifer)
        
        viewModel.delegate = self
        
    }
    
    //MARK: - Helpers
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    func locationRequest(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .notDetermined:
            break
        case .restricted, .denied:
            showMessage(withTitle: "Error", message: "You did not let us to get your location")
        case .authorizedAlways,.authorizedWhenInUse:
            showLoader(true)
                DispatchQueue.main.async {
                    self.fetchData()
                    self.showLoader(false)
                }
         default:
            showLoader(true)
        }
    }
    
    func fetchData(){
        
        viewModel.fetchWeather(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
}

//MARK: - WeatherViewModelDelegate

extension WeatherViewController : WeatherViewModelDelegate {
    
    func didUpdateWeather(_ viewModel: WeatherViewModel) {
        
        collectionView.reloadData()
        
    }
    
    func didFailWithError(_ error: Error) {
        
        self.showMessage(withTitle: "ERROR", message: "error : \(error.localizedDescription)")
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension WeatherViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifer", for: indexPath) as! WeatherCell
        
        cell.viewModel = viewModel
        
        return cell

    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension WeatherViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width)
        
        return CGSize(width: width, height: width)
    }
}
