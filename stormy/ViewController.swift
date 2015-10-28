//
//  ViewController.swift
//  stormy
//
//  Created by Justin Ferre on 10/26/15.
//  Copyright © 2015 Justin Ferre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var activityIndicatorlbl: UIActivityIndicatorView!
    @IBOutlet weak var btnLbl: UIButton!
    @IBOutlet weak var tempuratureLbl: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var rainLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    private let apiKey = "41b0cae2075d561e1ad8451408e4c2a0"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorlbl.hidden = true
        
        
       getCurrentWeather()
        
    }

    func getCurrentWeather() {
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(apiKey)/")!
        
        let forcastUrl = NSURL(string: "40.989402,-81.464143", relativeToURL: baseURL)!
        print(baseURL)
        print(forcastUrl)
        
        
        
        
        let sharedSession = NSURLSession.sharedSession()
        
      let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forcastUrl) { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            
        if location != nil { let dataObject = NSData(contentsOfURL: location!)
            do {
                let weatherData = try NSJSONSerialization.JSONObjectWithData(dataObject!, options: NSJSONReadingOptions()) as! [String:AnyObject]
                let currentWeather = Current(weatherDictionary: weatherData)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tempuratureLbl.text = "\(currentWeather.temperature)"
                    self.iconView.image = currentWeather.icon
                    self.currentTime.text = "\(currentWeather.currentTime)"
                    self.humidityLbl.text = "\(currentWeather.humidity)"
                    self.rainLbl.text = "\(currentWeather.precipProbability)"
                    self.summaryLbl.text = "\(currentWeather.summary)"
                    
                    
                    self.activityIndicatorlbl.stopAnimating()
                    self.activityIndicatorlbl.hidden = true
                    self.btnLbl.hidden = false
                    
                })
                
                
            }catch {
                print(error)
                let networkIssueController = UIAlertController(title: "Network Error", message: "Unable to connect", preferredStyle: .Alert)
                
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil )
                
                networkIssueController.addAction(okButton)
                let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil )
                networkIssueController.addAction(cancelButton)
                
                self.presentViewController(networkIssueController, animated: true, completion: nil)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.activityIndicatorlbl.stopAnimating()
                    self.activityIndicatorlbl.hidden = true
                    self.btnLbl.hidden = false
                })
            }
            } else {
                print(error)
                let networkIssueController = UIAlertController(title: "Network Error", message: "Unable to connect", preferredStyle: .Alert)
            
            let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil )
            
            networkIssueController.addAction(okButton)
            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil )
            networkIssueController.addAction(cancelButton)
                self.presentViewController(networkIssueController, animated: true, completion: nil)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicatorlbl.stopAnimating()
                self.activityIndicatorlbl.hidden = true
                self.btnLbl.hidden = false
            })
            
        }
        
        
        
        
        }
        
        
        
        downloadTask.resume()
        
        
        
    }
    
    @IBAction func refreshBtnPressed(sender: UIButton) {
        getCurrentWeather()
        btnLbl.hidden = true
        activityIndicatorlbl.hidden = false
        activityIndicatorlbl.startAnimating()
        
        
    }
    


}

