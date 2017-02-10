//
//  TimerViewController.swift
//  
//
//  Created by CAUADC on 2017. 2. 9..
//
//

import UIKit

class TimerViewController: UIViewController,UITableViewController {

    
    @IBOutlet weak var theLabel : UILabel
    var timer = NSTimer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func StartButton(sender: any)
 
   // timer = NSTimer.scheduledTimerWithTimeInterval(1.0)
    //https://www.youtube.com/watch?v=QKXZRRSlDss 참고
    @IBAction func StopButton(sender: any)
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
