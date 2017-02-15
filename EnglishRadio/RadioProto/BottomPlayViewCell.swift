//
//  BottomPlayTableViewCell.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 12..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class BottomPlayViewCell: UITableViewCell {

    var currentStation: StationData?
    var play = false
    override func awakeFromNib() {
        super.awakeFromNib()
        print("I awake")
        bottomPlayButton.addTarget(self, action: #selector(clickButton(sender:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(changeIsPlay(noti:)), name: PlayerSendIsPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getStationData(noti:)), name: PlayerSendStationData, object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func changeIsPlay(noti: Notification){
        
        if let isPlay: Bool = noti.userInfo?[UserInfoIsPlayKey] as? Bool{
            play = isPlay
            if isPlay{
                bottomPlayButton.setImage(#imageLiteral(resourceName: "newPauseSmall"), for: .normal)
            }
            else {
                bottomPlayButton.setImage(#imageLiteral(resourceName: "newPlaySmall"), for: .normal)
            }
        }
    }
    
    func getStationData(noti: Notification){
        if let station = noti.userInfo?[UserInfoStationKey] as? StationData{
            currentStation = station
            bottomStationLabel.text = currentStation?.getStationName()
        }
    }
    
    func clickButton(sender: UIButton){
        if (play){
            NotificationCenter.default.post(name: DidUserStop, object: nil, userInfo: nil)
        }
        else {
            let userInfoDic = [UserInfoStationKey:currentStation]
            NotificationCenter.default.post(name: DidUserPlay, object: nil, userInfo: userInfoDic)
        }
        
    }
    
    
    @IBOutlet weak var bottomPlayButton: UIButton!
    @IBOutlet weak var bottomStationLabel: UILabel!
}
