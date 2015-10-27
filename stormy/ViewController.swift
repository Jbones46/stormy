//
//  ViewController.swift
//  stormy
//
//  Created by Justin Ferre on 10/26/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private let apiKey = "41b0cae2075d561e1ad8451408e4c2a0"
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")!

        let forcastUrl = NSURL(string: "40.989402,-81.464143", relativeToURL: baseURL)!
                print(baseURL)
                print(forcastUrl)
     
        
        let sharedSession = NSURLSession.sharedSession()
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forcastUrl) { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            
            let dataObject = NSData(contentsOfURL: location!)
            do {
                let weatherData = try NSJSONSerialization.JSONObjectWithData(dataObject!, options: NSJSONReadingOptions()) as! [String:AnyObject]
                let currentWeather = Current(weatherDictionary: weatherData)
                print(currentWeather.currentTime)
                
                
            }catch {
                print(error)
            }
//            do {
//              let urlContents = try NSString(contentsOfURL: location!, encoding: NSUTF8StringEncoding)
//                print(urlContents)
//            }catch {
//                print(error)
//            }
            
            

        }
        
       
        
        downloadTask.resume()
        
        
        
    }

    


}

