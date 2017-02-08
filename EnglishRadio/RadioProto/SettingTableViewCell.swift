//
//  SettingTableViewCell.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 6..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var dataSettingSwitch: UISwitch!
    @IBAction func dataSettingSwitchAction(_ sender: UISwitch) {
        
        if dataSettingSwitch.isOn {
            print("스위치켜짐")
        } else {
            print("스위치꺼짐")
        }
    }
    
    
    
}
