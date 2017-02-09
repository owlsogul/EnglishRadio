//
//  StationData.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import SwiftyJSON

/** 스테이션의 데이터를 가지고 있는 클래스(구조체, 데이터 묶음) 입니다. */
class StationData{

    
    
    public init(id: Int, name: String, streaming: String, image: String, desc: String, country: String) {
        self.stationId = id
        self.stationName = name
        self.stationStreamURL = streaming
        self.stationImageURL = image
        self.stationDesc = desc
        self.stationCountry = country
    }
    
    //
    // Class Field Varation
    //
    private var stationId: Int = 0
    // Name of Station
    private var stationName: String = ""
    private var stationStreamURL: String = ""
    private var stationImageURL: String = ""
    // Description of Station
    private var stationDesc: String = ""
    private var stationCountry: String = ""
    

    class func parseStation(stationJSON: JSON) -> (StationData) {
        
        let id        = stationJSON["id"].int ?? 0
        let name      = stationJSON["stationName"].string ?? ""
        let streamURL = stationJSON["URL"].string ?? ""
        let imageURL  = stationJSON["Image"].string ?? ""
        let desc      = stationJSON["desc"].string ?? ""
        let country   = stationJSON["country"].string ?? ""

        let station = StationData(id: id, name: name, streaming: streamURL, image: imageURL, desc: desc, country: country)
        return station
    }
    
    
    
    //
    // Station Id
    //
    /** Station의 아이디값을 리턴하는 함수 */
    public func getStationId() -> Int{
        return self.stationId
    }
    
    public func setStationId(id: Int) -> () {
        self.stationId = id;
    }
    
    //
    // Station Name
    //
    /** Station의 이름값을 리턴하는 함수 */
    public func getStationName() -> String{
        return self.stationName
    }
    
    public func setStationName(name: String) -> () {
        self.stationName = name;
    }
    
    //
    // Streaming URL
    //
    /** Station의 스트리밍 주소값을 리턴하는 함수 */
    public func getStreamingURL() -> String{
        return self.stationStreamURL
    }
    
    public func setStreamingURL(url: String) -> () {
        self.stationStreamURL = url;
    }
    
    //
    // image URL
    //
    /** Station의 이미지 주소값을 리턴하는 함수 */
    public func getImageURL() -> String{
        return self.stationImageURL
    }
    
    public func setImageURL(url: String) -> () {
        self.stationImageURL = url;
    }
    
    //
    // Description
    //
    /** Station의 설명값을 리턴하는 함수 */
    public func getDescription() -> String{
        return self.stationDesc
    }
    
    public func setDescription(url: String) -> () {
        self.stationDesc = url;
    }
    
    /** Station의 나라값을 리턴하는 함수 */
    public func getStationCountry() -> String{
        return self.stationCountry
    }
    
    public func setStationCountry(country: String) -> () {
        self.stationCountry = country;
    }
    
}
