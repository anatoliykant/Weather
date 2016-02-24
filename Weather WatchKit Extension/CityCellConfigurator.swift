//
//  CityCellConfigurator.swift
//  Weather
//
//  Created by anatoliy.kant on 24.02.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import WatchKit

class CityCellConfigurator: NSObject {
    
    @IBOutlet var cityNameLabel: WKInterfaceLabel!
    var cityName = "" {
        
                didSet{
            cityNameLabel.setText(cityName)
        }
    }
}
