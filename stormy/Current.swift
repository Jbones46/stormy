//
//  Current.swift
//  stormy
//
//  Created by Justin Ferre on 10/27/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import Foundation

struct Current {
    private var _currentTime: String?
    private var _temperature: Int
    private var _humidity: Double
    private var _precipProbability: Double
    private var _summary: String
    private var _icon: String
    private var _currentTimeIntValue: Int
    
    
    var  currentTime: String {
        return _currentTime!
    }
    
    var temperature: Int {
        return _temperature
    }
    
    var humidity: Double {
        return _humidity
    }
    
    var precipProbability: Double {
        return _precipProbability
    }
    
    var summary: String {
        
        return _summary
    }
    
    var icon: String {
        return _icon
    }
    
    
    init(weatherDictionary: NSDictionary) {
       
        
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
         _currentTimeIntValue = currentWeather["time"] as! Int
        
        _temperature = currentWeather["temperature"] as! Int
        _humidity = currentWeather["humidity"] as! Double
        _precipProbability = currentWeather["precipProbability"] as! Double
        _summary = currentWeather["summary"] as! String
        _icon = currentWeather["icon"] as! String
        _currentTime = dateStringFromUnixTime(_currentTimeIntValue)
        
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        
        let timeInSeconds = NSTimeInterval(unixTime)
        
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
        
        
        
        
    }
    
    
    
}