//
//  ChannelViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{

    let stationData: [[String:String]] =
        [["Country" : "Canada","stationName" : "CKRW"],
        
         ["Country" : "United States", "stationName" : "CNN"],
         
         ["Country" : "Australia", "stationName" : "Australia Radio"],
         
         ["Country" : "United Kingdom", "stationName" : "UK Radio"]
         
    ]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
    }

    @IBAction func NavigationBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //row의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0 {
            
            return 1
        }else if section == 1 {
            
            return 1
        }else if section == 2 {
            
            return 1
        }else
        {
            return 1
        }
        
        
    }
    
    //섹션 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return stationData.count
    }
   
    
    //섹션 헤더에 나라 이름을 표시해준다.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionNumber:Int = section
        let stationDictionary:[String:String] = self.stationData[sectionNumber]
        
        
        return "\(stationDictionary["Country"]!)"
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationListCell", for: indexPath) as! ChannelTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.stationLabel?.textColor = UIColor.white.withAlphaComponent(0.8)

        let stationDictionary:[String:String] = self.stationData[indexPath.section]
        if let station: String = stationDictionary["stationName"]{
        
        
            if stationDictionary["Country"] == "United States"{
              
                print("US")
                cell.stationLabel?.text = station
                return cell
                
            
            }
            if stationDictionary["Country"] == "United Kingdom"{
                
                print("UK")
                cell.stationLabel?.text = station
                return cell
                
            }
            if stationDictionary["Country"] == "Canada"{
               
                print("Canada")
                cell.stationLabel?.text = station
                return cell
                
            }
            if stationDictionary["Country"] == "Australia"{
              
                print("Australia")
                cell.stationLabel?.text = station
                return cell

            }
            
        }
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
