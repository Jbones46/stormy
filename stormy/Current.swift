//
//  Current.swift
//  stormy
//
//  Created by Justin Ferre on 10/27/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import Foundation
import UIKit


struct Current {
    private var _currentTime: String?
    private var _temperature: Int
    private var _humidity: Double
    private var _precipProbability: Double
    private var _summary: String
    private var _icon: UIImage?
    private var _currentTimeIntValue: Int
    private var _iconString: String
    
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
    
    var icon: UIImage {
        return _icon!
    }
    
    
    init(weatherDictionary: NSDictionary) {
       
        
        let currentWeather = weatherDictionary["currently"] as! NSDictionary
        
         _currentTimeIntValue = currentWeather["time"] as! Int
        _iconString = currentWeather["icon"] as! String
        _temperature = currentWeather["temperature"] as! Int
        _humidity = currentWeather["humidity"] as! Double
        _precipProbability = currentWeather["precipProbability"] as! Double
        _summary = currentWeather["summary"] as! String
        _icon = weatherIconFromString(_iconString)
        _currentTime = dateStringFromUnixTime(_currentTimeIntValue)
        
    }
    
    func dateStringFromUnixTime(unixTime: Int) -> String {
        
        let timeInSeconds = NSTimeInterval(unixTime)
        
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
        
        
        
        
    }
    
    func weatherIconFromString(stringIcon: String) -> UIImage {
        
        var imageName: String
        
        switch stringIcon {
        case "clear-day":
            imageName = "clear-day"
        case "clear-night":
            imageName = "clear-night"
        case "rain":
            imageName = "rain"
        case "snow":
            imageName = "snow"
        case "sleet":
            imageName = "sleet"
        case "wind":
            imageName = "wind"
        case "fog":
            imageName = "fog"
        case "cloudy":
            imageName = "cloudy"
        case "partly-cloudy-day":
            imageName = "partly-cloudy"
        case "partly-cloudy-night":
            imageName = "cloudy-night"
        default:
            imageName = "default"
        }
        
        let iconName = UIImage(named: imageName)
        return iconName!
            
        }
        
        
    }
    
    
