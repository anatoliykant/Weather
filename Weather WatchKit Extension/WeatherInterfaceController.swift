//
//  WeatherInterfaceController.swift
//  Weather
//
//  Created by Nikolay Shubenkov on 24/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire


class WeatherInterfaceController: WKInterfaceController {
    
    var city:String = ""{
        didSet{
            cityLabel.setText(city)
        }
    }
    
    
    
    
    @IBOutlet var temperatureLabel: WKInterfaceLabel!
    @IBOutlet var cityLabel: WKInterfaceLabel!
    @IBOutlet var weatherImage: WKInterfaceImage!
    @IBOutlet var humidityLabel: WKInterfaceLabel!
    let apiclient = APIClient()
    private var updatedOnce = false
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        humidityLabel.setText("-")
        temperatureLabel.setText("-")
        cityLabel.setText(city)
        if city.characters.count == 0 {
            city = "Tula"
            updatedOnce = false
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateDataIfNeeded()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func updateDataIfNeeded(){
        if updatedOnce {
            return
        }
        
        apiclient.getWeatherFor(city){ result in
            print(result)
            
            switch result {

            case .success(let temperature, let humidity, let iconURL):
                self.temperatureLabel.setText(temperature)
                self.humidityLabel.setText(humidity)                
                self.updatedOnce = true
                Alamofire.request(Method.GET, iconURL).responseData({ (imageResult) -> Void in
                    if imageResult.result.isSuccess {
                        self.weatherImage.setImage(UIImage(data: imageResult.result.value!))
                    }
                    
                })
                
                
            case .error(let error):
                print(error)
            }
            
            
            //            Alamofire.request(.GET, result.iconURL)
//            Alamofire.request(.GET,result.iconURL
//)
            //            switch result
        }
    }
}
