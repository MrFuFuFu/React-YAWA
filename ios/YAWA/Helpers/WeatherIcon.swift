//
//  WeatherIcon.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation

/// https://erikflowers.github.io/weather-icons/
/// according to this website
struct WeatherIcon {
    let iconText: String
    var code: String?
    
    enum IconType: String, CustomStringConvertible {
        case ClearSkyDay = "01d"
        case ClearSkyNight = "01n"
        case FewCloudsDay = "02d"
        case FewCloudsNight = "02n"
        case ScatteredCloudsDay = "03d"
        case ScatteredCloudsNight = "03n"
        case BrokenCloudsDay = "04d"
        case BrokenCloudsNight = "04n"
        case ShowerRainDay = "09d"
        case ShowerRainNight = "09n"
        case RainDay = "10d"
        case RainNight = "10n"
        case ThunderstormDay = "11d"
        case ThunderstormNight = "11n"
        case SnowDay = "13d"
        case SnowNight = "13n"
        case MistDay = "50d"
        case MistNight = "50n"
        
        
        var description: String {
            switch self {
                case .ClearSkyDay: return "\u{f00d}"
                case .ClearSkyNight: return "\u{f02e}"
                case .FewCloudsDay: return "\u{f002}"
                case .FewCloudsNight: return "\u{f086}"
                case .ScatteredCloudsDay: return "\u{f041}"
                case .ScatteredCloudsNight: return "\u{f041}"
                case .BrokenCloudsDay: return "\u{f013}"
                case .BrokenCloudsNight: return "\u{f013}"
                case .ShowerRainDay: return "\u{f01a}"
                case .ShowerRainNight: return "\u{f01a}"
                case .RainDay: return "\u{f008}"
                case .RainNight: return "\u{f036}"
                case .ThunderstormDay: return "\u{f010}"
                case .ThunderstormNight: return "\u{f03b}"
                case .SnowDay: return "\u{f00a}"
                case .SnowNight: return "\u{f038}"
                case .MistDay: return "\u{f003}"
                case .MistNight: return "\u{f04a}"
            }
        }
        
    }
    
    init(code: String) {
        guard let iconType = IconType(rawValue: code) else {
            iconText = ""
            return
        }
        self.code = code
        iconText = iconType.description
    }
}
