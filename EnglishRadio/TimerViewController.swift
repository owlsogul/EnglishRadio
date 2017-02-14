//
//  TimerViewController.swift
//
//
//  Created by CAUADC on 2017. 2. 9..
//
//

import UIKit

class TimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    var startTime: TimeInterval?
    var checkTimes: [TimeInterval] = []
    let dateFromatter: DateFormatter = DateFormatter()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var theLabel : UILabel!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        dateFromatter.dateFormat = "yyyy-MM-dd -a hh:mm:ss"
        
    }
    
    func timerResult(){
        let theDate = Date()  // 지금시간 롸잇나우
        theLabel.text = self.dateFromatter.string(from: theDate)
        
    }
    
    @IBAction func StartButton(sender: AnyObject){
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerResult), userInfo: nil, repeats: true)
        
        self.startTime = NSDate.timeIntervalSinceReferenceDate
        self.checkTimes = []
        
        
    }
    
    // timer = NSTimer.scheduledTimerWithTimeInterval(1.0)
    //https://www.youtube.com/watch?v=QKXZRRSlDss 참고
    @IBAction func StopButton(sender: AnyObject){
        
        self.appendLap()
        timer.invalidate()
        
    }
    
    
    
    @IBAction func LapButton(sender: AnyObject){
        self.appendLap()
    }
    
    
    func appendLap() {
        
        
        let lastIndex = IndexPath(row: self.checkTimes.count, section: 0)
        
        self.checkTimes.append(NSDate.timeIntervalSinceReferenceDate)
        
        self.tableView.insertRows(at: [lastIndex], with: UITableViewRowAnimation.automatic)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.checkTimes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LapCell", for: indexPath)
        
        let date = Date(timeIntervalSinceReferenceDate: self.checkTimes[indexPath.row])
        
        cell.textLabel?.text = self.dateFromatter.string(from: date)
        
        return cell
    }
}


    

