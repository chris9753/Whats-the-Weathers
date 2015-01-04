//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Christopher Da Silva on 2015-01-04.
//  Copyright (c) 2015 Christopher Da Silva. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var weatherResult: UILabel!
    @IBAction func findOut(sender: AnyObject) {
        self.view.endEditing(true)
        
        var urlString = "http://www.weather-forecast.com/locations/" + cityName.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
        var url = NSURL(string: urlString)
        
        
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data,response,error) in
            

            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            
            
            if ((urlContent?.containsString("</span>"))==true){
            var contentArray = (urlContent as String).componentsSeparatedByString("<span class=\"phrase\">")
            var newContent = (contentArray[1] as String).componentsSeparatedByString("</span>")
            
                
                dispatch_async(dispatch_get_main_queue()){
                    self.weatherResult.text = newContent[0].stringByReplacingOccurrencesOfString("&deg;", withString: "°")
                }
                
            }else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.weatherResult.text="We're Sorry, Please enter in a valid city name."
                }
                
            }
            
        }
         task.resume()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

