//
//  Date.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation

extension Date {
    
    static func stringToDate(_ dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: dateStr)
    }
    
    static func dateToTimeString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static func dateToDayTimeNameString(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeStr = dateFormatter.string(from: date)
        switch timeStr {
        case DayTime.Overnight.rawValue:
            return "Overnight"
        case DayTime.Morning.rawValue:
            return "Morning"
        case DayTime.Afternoon.rawValue:
            return "Afternoon"
        case DayTime.Evening.rawValue:
            return "Evening"
        default:
            break
        }
        return ""
    }
    
    static func dateToDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"
        return dateFormatter.string(from: date)
    }
    
    static func dateToTimeDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMM"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    static func isSameDay(date1: Date?, date2: Date?) -> Bool {
        if date1 == nil || date2 == nil{
            return false
        }
        return Calendar.current.isDate(date1!, inSameDayAs: date2!)
    }
    
    static func timeCheck(_ dayTime: DayTime, date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        let timeO = dateToTimeString(date)
        return dayTime.rawValue == timeO
    }
}
