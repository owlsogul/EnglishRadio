//
//  ChannelViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{

    
    let country: [String] = ["Canada", "United States", "Australia", "United Kingdom"]
    
    var sdManager:StationDataManager = StationDataManager()
   
    var arrangedCountry: [String] = []
    var stationsInCountry: [String: [StationData]] = [:]
    var arrangedStation: [String: [StationData]] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //일단 테스트. 받아와야함
        sdManager.loadStationsFromJSON()
        //
        
        // 딕셔너리 초기화
        
        arrangedCountry = country.sorted(by: {(left:String, right:String) -> Bool
            in return left < right})
        
        for countryName in arrangedCountry {
            stationsInCountry[countryName] = Array<StationData>()
            arrangedStation[countryName] = Array<StationData>()
            print(countryName)
        }
        
        // 스테이션 데이터 딕셔너리에 넣기
        for station in sdManager.stations {
            stationsInCountry[station.getStationCountry()]?.append(station)
            print(station.getStationCountry() + " : \(stationsInCountry[station.getStationCountry()]?.count)")
        }

        // 딕셔너리 정렬
        for countryName in arrangedCountry {
            arrangedStation[countryName] = stationsInCountry[countryName]?.sorted(by: {
                (left:StationData, right: StationData) -> Bool in
                return left.getStationName() < right.getStationName()
            })
        }
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
       
        tableView.separatorStyle = .none
        
    }
  
    //row의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        print("Row In Section\(section)")
        if let stationCountry = arrangedStation[arrangedCountry[section]] {
            return stationCountry.count + 1
        }
        else {
            return 0
        }
        
        
        
    }
    
    //섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrangedCountry.count
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 22.0
        }
        return 44.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        
        let section = indexPath.section
        let row = indexPath.row
        if row == 0 {
            
            let header: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! ChannelTableViewCell
            header.setEditing(false, animated: false)
            header.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            header.headerLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
            header.headerLabel?.text = arrangedCountry[section]
            
            return header
            
        }
        else {
            
            let cell: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationListCell", for: indexPath) as! ChannelTableViewCell
            
            let countryName = arrangedCountry[section]
            
            cell.backgroundColor = UIColor.clear
            cell.stationLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
            
            if let station = arrangedStation[countryName]?[row-1] {
                cell.stationLabel.text = station.getStationName()
            }
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.clear
            } else {
                cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
            }
            
            
            return cell
        }
        
    }
    
    
    
    
    // MARK: - Navigation
    @IBAction func NavigationBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }

    

}
