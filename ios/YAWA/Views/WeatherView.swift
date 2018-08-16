//
//  WeatherView.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDesc: UILabel!

    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            labelTime.text = Date.dateToDayTimeNameString(weather.date)
            
            labelWeather.text = WeatherIcon(code: weather.icon).iconText
            let temp = Double(weather.temp)
            if let tempDouble = temp {
                labelTemp.text = String(Int(tempDouble)) + "℃"
            }
            labelDesc.text = weather.desc
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
}
