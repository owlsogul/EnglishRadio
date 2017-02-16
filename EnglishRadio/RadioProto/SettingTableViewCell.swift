//
//  SettingTableViewCell.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 6..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell,UITableViewDelegate {

    static var dataLimit: Int?
    var valueInput: Bool = false
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataUsageLabel: UILabel!
    @IBOutlet weak var dataSettingSwitch: UISwitch!
  
    @IBAction func dataSettingSlider(_ sender: UISlider) {
        
        let dataUsage = Int(sender.value*500)
        let time = Int((dataUsage * 1000)/720)
        let hours = Int(time/60)
        let minutes = Int(time%60)
        
        
        dataUsageLabel.text = "about \(hours) hr \(minutes) min"
        dataTextField.text = "\(dataUsage) MB"
        
        SettingTableViewCell.dataLimit = dataUsage
         
        
        
    }
    
 
   
    
    
    
    
}
