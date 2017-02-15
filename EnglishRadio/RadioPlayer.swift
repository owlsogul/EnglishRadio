//
//  RadioPlayer.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 15..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import Foundation
import MediaPlayer

let DidUserPlay = NSNotification.Name("DidUserPlay")
let DidUserPause = NSNotification.Name("DidUserPause")
let DidUserNext = NSNotification.Name("DidUserNext")
let DidUserPrev = NSNotification.Name("DidUserPrev")

class RadioPlayer {
    
    let radioPlayer = MPMoviePlayerController()
    
    
    // ########################################
    // MARK: Init
    // ########################################
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(observeUserNext(noti:)), name: DidUserNext, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeUserPrev(noti:)), name: DidUserPrev, object: nil)
    }
    
    func observeUserPlay(noti: Notification){
        
    }
    
    func observeUserPause(noti: Notification){
        
    }
    
    func observeUserNext(noti: Notification){
        
    }
    
    func observeUserPrev(noti: Notification){
        
    }
    
    
    
    
    
}
