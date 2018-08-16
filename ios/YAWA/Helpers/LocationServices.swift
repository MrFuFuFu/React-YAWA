//
//  LocationServices.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServices {
    
    static let shared = LocationServices()
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let inUse = CLAuthorizationStatus.authorizedWhenInUse
    
    func getAdress(completion: @escaping (_ region: String) -> ()) {
        let authStatus = CLLocationManager.authorizationStatus()
        self.locManager.requestWhenInUseAuthorization()
        if authStatus == inUse {
            self.currentLocation = locManager.location
            if self.currentLocation == nil {
                completion("Auckland")
                return
            }
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { placemarks, error in
                if let _ = error {
                    completion("Auckland")
                } else {
                    let placemark = placemarks?[0]
                    let locality = (placemark?.locality != nil ? placemark?.locality : placemark?.administrativeArea) ?? "Auckland"
                    if let regionCode = Locale.current.regionCode {
                        completion(locality + "," + regionCode)
                    } else {
                        completion(locality)
                    }
                }
            }
        } else {
            completion("Auckland")
        }
    }
}
