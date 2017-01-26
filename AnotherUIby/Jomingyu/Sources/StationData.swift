//
//  StationData.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 1. 24..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit



class StatoinData{
    
    var stationName :String
    var stationStreamURL :String
    var stationImageURL :String
    var stationDesc :String
    var stationLongDesc :String
    
    init(name: String, streamURL: String, imageURL: String, desc: String, longDesc: String) {
        self.stationName      = name
        self.stationStreamURL = streamURL
        self.stationImageURL  = imageURL
        self.stationDesc      = desc
        self.stationLongDesc  = longDesc
    }


    
    
    
    
}
