//
//  TimerViewController.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 13..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class TimerViewController: ViewController {
    
    @IBOutlet weak var theLabel: UILabel!
    var timer = Timer()
    var seconds : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickStartButton(sender:AnyObject){
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: ("timeResults"), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func clickStopButton(sender:AnyObject){
        
        timer.invalidate()
        
    }
    
    func timerResults(){
        let theDate = NSDate()
        
        theLabel.text = "\(theDate)"
    }
    
    
}
