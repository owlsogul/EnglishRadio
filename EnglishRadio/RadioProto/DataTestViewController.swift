//
//  DataTestViewController.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 8..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

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
        print(sdManager.stations[1])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
