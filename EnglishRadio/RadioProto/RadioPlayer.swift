//
//  RadioPlayer.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 15..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import MediaPlayer

/** 스테이션 데이터가 유저인포로 들어갈때는 반드시 이 키를 사용해야함 */
let UserInfoStationKey = "stationData"

// Player Control Notifications
let DidUserPlay = NSNotification.Name("DidUserPlay")
let DidUserPause = NSNotification.Name("DidUserPause")
let DidUserStop = NSNotification.Name("DidUserStop")

//Error Notifications
let PlayerError = NSNotification.Name("PlayerError")
let ErrorUserInfoKeyName = "error"
// Error Key Name
let StationNotExist = "NO_STATION"

/** 플레이어한테 스테이션 데이터를 요구하는 노티피케이션 */
let SenderRequestStationData = NSNotification.Name("SenderRequestStationData")
/** 플레이어가 스테이션 데이터를 보내는 노티피케이션 */
let PlayerSendStationData = NSNotification.Name("PlayerSendStationData")

class RadioPlayer {
    
    let radioPlayer = MPMoviePlayerController()
    
    var currentStation: StationData?
    
    //########################################
    // MARK: Init
    //########################################
    
    init(){
        
        setupPlayer()
        registerBackgroundPlay()
        registerNotificationCenter()
        
    }
    
    func setupPlayer(){
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.none
    }
    
    func registerBackgroundPlay(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func registerNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(observeUserPlay(noti:)), name: DidUserPlay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeUserPause(noti:)), name: DidUserPause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeUserStop(noti:)), name: DidUserStop, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(observeRequestStationData(noti:)), name: SenderRequestStationData, object: nil)
    }
    
    //########################################
    // MARK: Notification Observer
    //########################################
    
    @objc func observeUserPlay(noti: Notification){
        print("플레이 노티를 받았다")
        if let tmpStation = noti.userInfo?[UserInfoStationKey] as? StationData {
            print("정상적으로 스테이션이 전송되었습니다.")
            self.currentStation = tmpStation
            self.playRadio()
        }
        else {
            print("스테이션이 정상적으로 전송되지않아 에러 노티피케이션을 송출합니다.")
            let userInfoDic = [ErrorUserInfoKeyName : StationNotExist]
            NotificationCenter.default.post(name: PlayerError, object: nil, userInfo: userInfoDic)
        }
    }
    
    @objc func observeUserPause(noti: Notification){
        print("일시정지 노티를 받았다")
        pauseRadio()
    }
    
    @objc func observeUserStop(noti: Notification){
        print("정지 노티를 받았다")
        stopRadio()
    }
    
    @objc func observeRequestStationData(noti: Notification){
        print("스테이션 요구 노티를 받았다")
        let userInfoDic: [String: StationData?] = [UserInfoStationKey:currentStation]
        NotificationCenter.default.post(name: PlayerSendStationData, object: nil, userInfo: userInfoDic)
        print("스테이션 요구를 들어주기 위해 노티에 실어보냈다.")
    }
    
    //########################################
    // MARK: Cotrol Functions(Play, Pause ...)
    //########################################
    
    func playRadio(){
        // TODO: 스톱 하고 안하고 차이가 무엇인지
        //radioPlayer.stop()
        radioPlayer.contentURL = URL(string: (currentStation?.getStreamingURL())!)
        radioPlayer.prepareToPlay()
        radioPlayer.play()
    }
    
    func pauseRadio(){
        radioPlayer.pause()
    }
    
    func stopRadio(){
        radioPlayer.stop()
    }
    
    
    
}
