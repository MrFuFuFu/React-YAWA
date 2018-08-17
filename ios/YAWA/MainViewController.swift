//
//  MainViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 16/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit
import React
import CoreLocation
import Toast_Swift

class MainViewController: UIViewController {
    var arrayWeathers: [[Weather]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initLocationService()
    }

    @IBAction func onReactYAWAClick(_ sender: UIButton) {
        locationRequest()
    }
    
    private func launchReactPage(weathers: NSDictionary) {
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
        let mockData:NSDictionary = ["scores":
            [
                ["name":"Alex", "value":"42"],
                ["name":"Joel", "value":"10"]
            ]
        ]
        
        //        let rootView = RCTRootView(
        //            bundleURL: jsCodeLocation,
        //            moduleName: "RNHighScores",
        //            initialProperties: mockData as [NSObject : AnyObject],
        //            launchOptions: nil
        //        )
        
        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "FlatListBasics",
            initialProperties: weathers as [NSObject : AnyObject],
            launchOptions: nil
        )
        
        let vc = UIViewController()
        vc.view = rootView
        self.present(vc, animated: true, completion: nil)
    }
    
    private func weathersToDictionary() {
        var weatherData: [[NSDictionary]] = []
        for weathers in arrayWeathers {
            var arrayWeathers: [NSDictionary] = []
            for weather in weathers {
                arrayWeathers.append(weather.toDictionary())
            }
            weatherData.append(arrayWeathers)
        }
        let weathers: NSDictionary = ["AllWeather": weatherData]
        launchReactPage(weathers: weathers)
    }
    
    
    // MARK: request
    
    private func locationRequest() {
        LocationServices.shared.getAdress { [weak self] locality in
            guard let `self` = self else { return }
            `self`.title = locality
            `self`.weatherRequest(locality: locality)
        }
    }
    
    private func weatherRequest(locality: String) {
        view.makeToastActivity(.center)
        APIs.shared.requestForecastBy(locality: locality) { [weak self] (arrayWeathers, error) in
            guard let `self` = self else { return }
            `self`.view.hideToastActivity()
            if let arrayWeathers = arrayWeathers, arrayWeathers.count > 0 {
                `self`.title = locality
                `self`.arrayWeathers = arrayWeathers
                `self`.weathersToDictionary()
            } else if let error = error {
                `self`.view.makeToast(error.localizedDescription, position: .center)
            } else {
                `self`.view.makeToast(NSLocalizedString("No result", comment:""), position: .center)
            }
        }
    }
}


// MARK: Location delegate

extension MainViewController: CLLocationManagerDelegate {
    func initLocationService(){
        LocationServices.shared.locManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
        }
    }
}
