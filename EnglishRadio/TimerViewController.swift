//
//  TimerViewController.swift
//
//
//  Created by CAUADC on 2017. 2. 9..
//
//

import UIKit

class TimerViewController: UIViewController {
    
    
    @IBOutlet weak var theLabel : UILabel!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func timerResult(){
        let theDate = NSDate()
        theLabel.text="\(theDate)"
        
    }
    
    @IBAction func StartButton(sender: AnyObject){
        
      timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("timeResults"), userInfo: nil, repeats: true)
        
        
        
    }
    
    // timer = NSTimer.scheduledTimerWithTimeInterval(1.0)
    //https://www.youtube.com/watch?v=QKXZRRSlDss 참고
    @IBAction func StopButton(sender: AnyObject){
    
    timer.invalidate()
    
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
