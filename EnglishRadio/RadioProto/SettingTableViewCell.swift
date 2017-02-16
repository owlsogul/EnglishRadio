//
//  SettingTableViewCell.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 6..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell,UITableViewDelegate {

    static var dataLimit: Int = 99999
    var valueInput: Bool = false
    static var kbPerSec: Int = 12

    static var hours: Int = 0
    static var minutes: Int = 0
    
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataUsageLabel: UILabel!
    @IBOutlet weak var dataSettingSwitch: UISwitch!
  
    @IBAction func dataSettingSlider(_ sender: UISlider) {
        
        let dataUsage = Int(sender.value*500)
        let time = Int((dataUsage * 1000)/(SettingTableViewCell.kbPerSec*60))
        SettingTableViewCell.hours = Int(time/60)
        SettingTableViewCell.minutes = Int(time%60)
        
        dataTextField.textColor = UIColor.darkGray
        
        
        dataUsageLabel.text = "about \(SettingTableViewCell.hours) hr \(SettingTableViewCell.minutes) min"
        dataTextField.text = "\(dataUsage) MB"
        
        SettingTableViewCell.dataLimit = dataUsage
         
        
        
    }
    
 
   
    
    
    
    
}
