//
//  APIClient.swift
//  Wearther
//
//  Created by Nikolay Shubenkov on 24/02/16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import WatchKit
import Alamofire


enum WeatherResult {
    case success(temperature:String,humidity:String, iconURL:String)
    case error(String)
}

class APIClient: NSObject {
    func getWeatherFor(city:String, completion:((result:WeatherResult)->Void)){
        
        //api.worldweatheronline.com/free/v2/weather.ashx?q=London&format=json&num_of_days=5&key=0f7e73069a1f0238676df01e34d79
        
        Alamofire.request(.GET, "http://api.worldweatheronline.com/free/v2/weather.ashx", parameters: ["q":city,
            "format":"json",
            "num_of_days":1,
            "key":"0f7e73069a1f0238676df01e34d79"
            ]).responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    completion(result:WeatherResult.error("something wrong happend"))
                    return
                }
                
                if  let info = response.result.value as? [String:AnyObject],
                    let data = info["data"] as? [String:AnyObject],
                    let conditionArray = data["current_condition"] as? [AnyObject],
                    let condition = conditionArray.first as? [String:AnyObject],
                    let temperature = condition["FeelsLikeC"] as? String,
                    let humidity = condition["humidity"] as? String,
                    let weatherIconUrlArray = condition["weatherIconUrl"] as? [AnyObject],
                    let weatherIconUrl = weatherIconUrlArray.first as? [String : String],
                    let url = weatherIconUrl["value"]{
                        completion(result:WeatherResult.success(temperature: temperature, humidity: humidity, iconURL: url))
                }
                /*"data": {
                "current_condition": [
                {
                "cloudcover": "0",
                "FeelsLikeC": "4",
                "FeelsLikeF": "39",
                "humidity": "75",
                "observation_time": "10:29 PM",
                "precipMM": "0.0",
                "pressure": "1021",
                "temp_C": "4",
                "temp_F": "39",
                "visibility": "10",
                "weatherCode": "113",
                "weatherDesc": [
                {
                "value": "Clear"
                }
                ],
                "weatherIconUrl": [
                {
                "value": "http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0008_clear_sky_night.png"
                }
                ],
                "winddir16Point": "N",
                "winddirDegree": "0",
                "windspeedKmph": "0",
                "windspeedMiles": "0"
                }
                ]*/
                
                
                
        }
        
    }
}
