//
//  FavoriteManager.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 10..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import RealmSwift


class FavoriteManager {
    
    var favStationArr: Results<StationInfo>?
    var favStationMap: [Int: StationInfo] = [:]
    var sdManager: StationDataManager = StationDataManager()
       init(){self.load()}
    
    func register(sdManager: StationDataManager){
        self.sdManager = sdManager
        
        let realm = try? Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        self.favStationArr = realm?.objects(StationInfo.self)
        print("Favorite Manager Inside Test : \(favStationArr?.count)")
        
        if ((favStationArr?.count) ?? 0 > 0){
            for fav in favStationArr!{
                favStationMap[fav.favoriteID] = fav
            }
        }
    }
    
    /**
     
     favStationArr 을 쓰기전에는 항상 써줘야 함
     
     */
    func load(){
        
        // Realm을 초기화하여 realm 이라는 이름으로 사용합니다
        let realm = try? Realm()
        
        // PhotoInfo에 해당하는 자료들을 데이터베이스에서 불러와서 photoInfos에 넣어줍니다
        self.favStationArr = realm?.objects(StationInfo.self)
        print("Favorite Manager Inside Test : \(favStationArr?.count)")
        
    }
    
    /**
     
     Favorite을 추가한다
     
     */
    func addFavorite(id: Int) -> Bool{
        
        let realm = try? Realm()
        
        if let station = sdManager.stationMap[id]{
            let info = StationInfo()
            info.favoriteID = station.getStationId()
            info.stationData = station.getStationName()
            info.stationCountry = station.getStationCountry()
            favStationMap[id] = info
            try? realm?.write {
                realm?.add(info)
            }
            return true
        }
        else {
            return false
        }
        
    }
    
    /**
     
     Favorite을 삭제한다
     
     */
    func delFavorite(id: Int){
        
        let realm = try? Realm()
        
        if let info = favStationMap[id] {
            try? realm?.write {
                realm?.delete(info)
            }
            favStationMap.removeValue(forKey: id)
        }

        
    }
    
    /**
     
     Favorite인지 확인한다.
     
     */
    func isFavorite(id: Int) -> Bool {
        if favStationMap[id] == nil {
            return false
        }
        else {
            return true
        }
    }
    
    
}
