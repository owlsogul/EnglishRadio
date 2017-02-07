//
//  StationData.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation

class StationData{

    public init?(name: String, streaming: String, image: String, desc: String) {
        self.stationName = name
        self.streamingURL = streaming
        self.imageURL = image
        self.desc = desc
    }
    
    //
    // Class Field Varation
    //
    // Name of Station
    private var stationName: String = ""

    private var streamingURL: String = ""
    
    private var imageURL: String = ""
    
    // Description of Station
    private var desc: String = ""
    
    
    //
    // Station Name
    //
    public func getStationName() -> String{
        return self.stationName
    }
    
    public func setStationName(name: String) -> () {
        self.stationName = name;
    }
    
    //
    // Streaming URL
    //
    public func getStreamingURL() -> String{
        return self.streamingURL
    }
    
    public func setStreamingURL(url: String) -> () {
        self.streamingURL = url;
    }
    
    //
    // image URL
    //
    public func getImageURL() -> String{
        return self.imageURL
    }
    
    public func setImageURL(url: String) -> () {
        self.imageURL = url;
    }
    
    //
    // Description
    //
    public func getDescription() -> String{
        return self.desc
    }
    
    public func setDescription(url: String) -> () {
        self.desc = url;
    }
}
