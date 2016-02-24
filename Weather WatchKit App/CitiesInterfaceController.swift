//
//  CitiesInterfaceController.swift
//  Weather
//
//  Created by anatoliy.kant on 24.02.16.
//  Copyright © 2016 Nikolay Shubenkov. All rights reserved.
//

import WatchKit
import Foundation


class CitiesInterfaceController: WKInterfaceController {

    @IBOutlet var citiesTable: WKInterfaceTable!
    var citiesToShow = ["Moscow","Warsava","Washington","Norilsk","Kalinigrad","Dnepropetrovsk","Kirov","Vladivostok","Kemerov"]{
        didSet{
            updateTable()
        }
    }
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        updateTable()
        
        // Configure interface objects here.
    }
    
    func updateTable(){
        
        citiesTable.setNumberOfRows(citiesToShow.count, withRowType: "CityCell")
        
        for cellIndex in 0..<citiesToShow.count{
            if let cellConfigurator = citiesTable.rowControllerAtIndex(cellIndex) as? CityCellConfigurator{
                cellConfigurator.cityName = citiesToShow[cellIndex]
            }
        }
        //super.awakeWithContext(context)
        //updateTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
