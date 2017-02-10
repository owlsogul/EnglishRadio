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

    @IBOutlet weak var stationTitleLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var stationImage: UIImageView!
    
    let radioPlayer = MPMoviePlayerController()
    var playing: Bool = false
    var currentStation: StationData!
    let sdManager = StationDataManager()
    var firstPlay: Bool = true

    
    
    
    func setupPlayer(){
        radioPlayer.view.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        radioPlayer.view.sizeToFit()
        radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = false
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.none

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sdManager.loadStationsFromJSON()
        setupPlayer()
       
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickPlay(){
        if !playing{
                      playButton.setImage(#imageLiteral(resourceName: "newPause"), for: .normal)
            
            if firstPlay {

                let rand:UInt32 = arc4random_uniform(10) + 1
                currentStation = sdManager.stationMap[Int(rand)]
                radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
                firstPlay = false
            
            }
            print("Now Playing is : \(currentStation.getStationName())")
            radioPlayer.prepareToPlay()
            radioPlayer.play()
            playing = true
            
        }else {
            playButton.setImage(#imageLiteral(resourceName: "newPlay"), for: .normal)
            radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
            radioPlayer.stop()
            playing = false
            firstPlay = false
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
        
        let realm = try? Realm()
        
          let stationInfo: StationInfo = StationInfo()
        
        
        if playing {
            
            stationInfo.stationData = self.currentStation.getStationName()
            stationInfo.stationCountry = self.currentStation.getStationCountry()
            stationInfo.stationID = self.currentStation.getStationId()
            
         print(stationInfo)
            
            try? realm?.write {
                
                realm?.add(stationInfo)
                print("Success")
               
            }
        }
    }

 
 
}

