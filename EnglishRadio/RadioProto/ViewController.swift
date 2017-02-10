//
//  ViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 1. 9..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var bottomStationLabel: UILabel!
    @IBOutlet weak var stationTitleLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var stationImage: UIImageView!
    
    let radioPlayer = MPMoviePlayerController()
    var playing: Bool = false
    var currentStation: StationData!
    static var sdManager = StationDataManager()
    static var favManager = FavoriteManager()
    var firstPlay: Bool = true
  
    
    
    func setupPlayer(){
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.none
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.sdManager.loadStationsFromJSON()
        print("sdManager Load Test : \(ViewController.sdManager.getNumberOfStation())")
        ViewController.favManager.register(sdManager: ViewController.sdManager)
        print("favManger Load Test : \(ViewController.favManager.sdManager.getNumberOfStation())")
        
        setupPlayer()
       
        
    }

    func updateLockScreen() {
        
        // Update notification/lock screen
        let albumArtwork = MPMediaItemArtwork(image: #imageLiteral(resourceName: "albumArt"))
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyArtist: "",
            MPMediaItemPropertyTitle: currentStation.getStationName(),
            MPMediaItemPropertyArtwork: albumArtwork
        ]
    }
    
    @IBAction func clickPlay(){
        if !playing{
                      playButton.setImage(#imageLiteral(resourceName: "newPause"), for: .normal)
            
            if firstPlay {

                let rand:UInt32 = arc4random_uniform(40) + 1
                currentStation = ViewController.sdManager.stationMap[Int(rand)]
                radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
                firstPlay = false
            
            }
            print("Now Playing is : \(currentStation.getStationName())")
            bottomStationLabel.text = "\(currentStation.getStationName())"
            stationTitleLabel.text = "\(currentStation.getStationName())"
            detailTitleLabel.text = "\(currentStation.getStationCountry())"
     //       stationImage.loadImageWithURL(url: url)
            radioPlayer.prepareToPlay()
            radioPlayer.play()
            playing = true
            updateLockScreen()
            changeFavorite()
            
        }else {
            playButton.setImage(#imageLiteral(resourceName: "newPlay"), for: .normal)
            radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
            radioPlayer.stop()
            playing = false
            firstPlay = false
        }
        
    }
    
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        if playing{
            
            // 랜덤 스테이션 가져오기
            let rand:UInt32 = arc4random_uniform(40) + 1
            currentStation = ViewController.sdManager.stationMap[Int(rand)]
            
            // 스트리밍 시작
            print("Now Playing is : \(currentStation.getStationName())")
            radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
            radioPlayer.prepareToPlay()
            radioPlayer.play()
            playing = true
            firstPlay = false
            
            // 정보 갱신
            bottomStationLabel.text = "\(currentStation.getStationName())"
            stationTitleLabel.text = "\(currentStation.getStationName())"
            detailTitleLabel.text = "\(currentStation.getStationCountry())"
            changeFavorite()
            
            
        }
    }
    
    /**
     
     Favorite 버튼 갱신 할 때 쓰임!
     
     */
    func changeFavorite(){
        if ViewController.favManager.isFavorite(id: currentStation.getStationId()) {
            favoriteButton.setImage(#imageLiteral(resourceName: "newFavoriteFilled"), for: .normal)
        }
        else {
            favoriteButton.setImage(#imageLiteral(resourceName: "newFavorite"), for: .normal)
        }
    }
    
    
    //TODO: 꺼져도 계속 인풋을 받음 - 해결해야함
    override func viewWillDisappear(_ animated: Bool) {
        if playing{
            radioPlayer.play()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if playing{
            radioPlayer.play()
        }
    }
    
    // favourite button을 할수있게 버튼을 생성
    @IBAction func clickFavButton(_ sender: UIButton) {
        
        let stationInfo: StationInfo = StationInfo()
        
        if playing {
            if (ViewController.favManager.isFavorite(id: currentStation.getStationId())){
                ViewController.favManager.delFavorite(id: currentStation.getStationId())
                ViewController.favManager.load()
                print("del Favorite : \(ViewController.favManager.favStationArr?.count)")
            }
            else {
                stationInfo.stationData = self.currentStation.getStationName()
                stationInfo.favoriteID = self.currentStation.getStationId()
                stationInfo.stationCountry = self.currentStation.getStationCountry()
                if ViewController.favManager.addFavorite(id: currentStation.getStationId()){
                    ViewController.favManager.load()
                    print("Add Sucess : \(ViewController.favManager.favStationArr?.count)")
                }
                else {
                    print("Fail Add")
                }
            }
            changeFavorite()
        }
    
    }

 
 
}

