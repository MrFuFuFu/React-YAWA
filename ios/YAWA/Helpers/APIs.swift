//
//  APIs.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class APIs {
    static let shared = APIs()
    private let url: String = "http://api.openweathermap.org/data/2.5/"
    private let paramters: String = "?mode=json&units=metric&APPID=399a5bbd96e27a24b8f8c656e8c30ff4"
    
    func requestForecastBy(locality: String, completion: @escaping ([[Weather]]?, Error?) -> Void) {
        let encodeLocality = locality.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? locality
        let url = self.url + "forecast" + paramters + "&q=\(encodeLocality)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value as? [String: AnyObject] {
                    completion(Weather.operatWeather(json: JSON(result)), nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func requestTodayBy(locality: String, completion: @escaping (Weather?, Error?) -> Void) {
        let encodeLocality = locality.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? locality
        let url = self.url + "weather" + paramters + "&q=\(encodeLocality)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                if let result = response.result.value as? [String: AnyObject] {
                    completion(Weather.todayWeatherFormate(json: JSON(result)), nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
