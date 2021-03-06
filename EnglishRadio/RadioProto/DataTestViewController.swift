//
//  DataTestViewController.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 8..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import SystemConfiguration

class DataTestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sdManager = StationDataManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int = sdManager.stations.count
        print("station`s number : \(count)")
        return sdManager.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        let row : Int = indexPath.row
        cell.textLabel?.text = "\(sdManager.stations[row].getStationId()) : \(sdManager.stations[row].getStationName())"
        cell.detailTextLabel?.text = "\(sdManager.stations[row].getDescription())"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdManager.loadStationsFromJSON()
        
        //Test
        for station in sdManager.stations {
            print(sdManager.stationMap[station.getStationId()]?.getStationName() ?? "null")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let npvc = segue.destination as? NowPlayingViewController {
            if let ssender = sender as? StationData {
                npvc.currentStation = ssender
                print(npvc.currentStation.getStreamingURL())
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CellClick", sender: sdManager.stationMap[indexPath.row+1])
    }
    
}
