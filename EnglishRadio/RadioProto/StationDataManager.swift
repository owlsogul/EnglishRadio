//
//  StationDataManager.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 8..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import SwiftyJSON
/** 
 스테이션 데이터를 JSON에서 파싱하고, 관리하는 클래스
 
 사용법: 
 1. StationDataManager 객체를 만들어준다.
 2. loadStationFromJSON 함수를 호출한다.
 3. stations 배열을 사용한다. 또는. StationData
 
 스테이션 데이터를 사용할 때마다 JSON에서 파싱을 해오면 느려짐이 있을 것 같기때문에
 처음 만든 StationDataManager 를 다른 뷰로 넘겨주면서 (변수 넘겨주는 것과 같이) 사용하는 것이 좋아보인다 (개인적인 생각)
 */
class StationDataManager {
    
    /**
     StationData를 저장하고 있는 배열 
     */
    var stations: [StationData] = [StationData]()
    
    /**
     Station의 아이디값을 Key로,
     StationData를 Value로 가지고 있는 맵(딕셔너리)
     */
    var stationMap: [Int: StationData] = [Int: StationData]()
    
    /** 
     Station을 JSON으로부터 불러오는 함수
     */
    public func loadStationsFromJSON() {
        
        if let file = Bundle.main.path(forResource: "Station", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: file))
                let json = JSON(data: data)
                print("JSON!")
                if let stationArray = json["station"].array{
                    print(stationArray.count)
                    for stationJSON in stationArray{
                        let station = StationData.parseStation(stationJSON: stationJSON)
                        stations.append(station)
                        stationMap[station.getStationId()] = station;
                    }
                }
                else {
                    print(json)
                    print("array가 터졌다.")
                }
            } catch {
                print("열수가 없다")
            }
        } else {
            print("파일이 없다")
        }
    }
    
    /** 
     Station의 개수를 가지고 오는 함수
     */
    public func getNumberOfStation() -> (Int){
        return stations.count
    }

}
