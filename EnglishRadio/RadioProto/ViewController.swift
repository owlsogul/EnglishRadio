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
            let rand:UInt32 = arc4random_uniform(10) + 1
            currentStation = sdManager.stationMap[Int(rand)]
            

            radioPlayer.contentURL = URL(string: currentStation.getStreamingURL())
            print("Now Playing is : \(currentStation.getStationName())")
            radioPlayer.prepareToPlay()
            radioPlayer.play()
            playing = true
        }
        
    }

    @IBAction func clickPause(){
        if playing {
            print("Pause Button Clicked")
            radioPlayer.pause()
            playing = false
        }
    }
    
    
    //TODO: 꺼져도 계속 인풋을 받음 - 해결해야함
    override func viewWillDisappear(_ animated: Bool) {
        if playing{
            radioPlayer.stop()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if playing{
            radioPlayer.stop()
        }
    }
    

    
}

