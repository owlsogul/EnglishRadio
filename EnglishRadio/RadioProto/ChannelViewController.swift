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
    
    var stationsInCountry: [String: [StationData]] = [:]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        print("A")
        super.viewDidLoad()
        
        //일단 테스트. 받아와야함
        sdManager.loadStationsFromJSON()
        //
        print("B")
        for countryName in country {
            stationsInCountry[countryName] = Array<StationData>()
            print(countryName)
        }
        
        for station in sdManager.stations {
            stationsInCountry[station.getStationCountry()]?.append(station)
            print(station.getStationCountry() + " : \(stationsInCountry[station.getStationCountry()]?.count)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
    }
  
    //row의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        print("Row In Section\(section)")
        if let stationCountry = stationsInCountry[country[section]] {
            return stationCountry.count + 1
        }
        else {
            return 0
        }
        
        
        
    }
    
    //섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return country.count
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
            header.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            header.headerLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
            header.headerLabel?.text = country[section]
            
            return header
            
        }
        else {
            
            let cell: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationListCell", for: indexPath) as! ChannelTableViewCell
            
            let countryName = country[section]
            
            cell.backgroundColor = UIColor.clear
            cell.stationLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
            
            if let station = stationsInCountry[countryName]?[row-1] {
                cell.stationLabel.text = station.getStationName()
            }
            
            return cell
        }
        
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
       
    
    
    }
    

}
