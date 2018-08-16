//
//  TodayViewController.swift
//  YAWA
//
//  Created by Fu Yuan on 10/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var labelLocality: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelIcon: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelSunrise: UILabel!
    @IBOutlet weak var labelSunset: UILabel!
    @IBOutlet weak var labelIssued: UILabel!
    
    var locality: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        requestToday()
    }
    
    // MARK: Request
    
    private func requestToday() {
        self.view.makeToastActivity(.center)
        rootView.isHidden = true
        if let locality = locality {
            APIs.shared.requestTodayBy(locality: locality) { [weak self] (weather, error)  in
                guard let `self` = self else { return }
                `self`.view.hideToastActivity()
                `self`.rootView.isHidden = false
                if let weather = weather {
                    `self`.setToViews(weather: weather)
                } else if let error = error {
                    `self`.view.makeToast(error.localizedDescription, position: .center)
                } else {
                    `self`.view.makeToast(NSLocalizedString("No result", comment:""), position: .center)
                }
            }
        }
    }
    
    private func setToViews(weather: Weather) {
        labelLocality.text = locality
        if let date = weather.date {
            labelDate.text = Date.dateToDateString(date)
            labelIssued.text = "Issued " + Date.dateToTimeDateString(date)
        }
        
        labelIcon.text = WeatherIcon(code: weather.icon).iconText
        let temp = Double(weather.temp)
        if let tempDouble = temp {
            labelTemp.text = String(Int(tempDouble)) + "℃"
        }
        labelDesc.text = weather.desc
        
        labelPressure.text = String(weather.pressure ?? 0) + "hPa"
        labelHumidity.text = String(weather.humidity ?? 0) + "%"
        labelSunrise.text = weather.sunrise
        labelSunset.text = weather.sunset
    }
}
