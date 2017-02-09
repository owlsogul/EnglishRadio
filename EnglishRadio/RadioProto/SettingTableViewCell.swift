//
//  SettingTableViewCell.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 6..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell,UITableViewDelegate {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataSettingSwitch: UISwitch!
//    @IBAction func dataSettingSwitchAction(_ sender: UISwitch) {
//        
//        
//        
//        if dataSettingSwitch.isOn {
//          
//            print("on")
//            
//        } else {
//            
//             print("off")
//        }
//    }
    @IBAction func dataSettingSlider(_ sender: UISlider) {
        
        let index = sender.value
        dataUsageLabel.text = "\(index) GB"
    }
    @IBOutlet weak var dataUsageLabel: UILabel!

   
    
    
    
    
}
