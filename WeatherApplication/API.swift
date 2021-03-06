//
//  API.swift
//  WeatherApplication
//
//  Created by Shelton on 10/21/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import Foundation
import Fargo

public struct API{
    
    static func requestCurrentCityWeather(lat: String,lon:String,key: String,completion:(Result<DataModel>)->Void){
        let URLString = BackEndInfo.baseURLString + "weather?lat=\(lat)&lon=\(lon)&appid="+key
        Networking.GET(URLString,completion: completion)
    }


    

}
