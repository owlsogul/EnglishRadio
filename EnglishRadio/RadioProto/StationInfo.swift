//
//  StationInfo.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 9..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import RealmSwift


class StationInfo: Object {
    
    dynamic var stationData : String? = nil
    dynamic var stationID = 0
    dynamic var stationCountry: String? = nil
    dynamic var favoriteID:Int = 0
    
}
