//
//  TimerViewController.swift
//
//
//  Created by CAUADC on 2017. 2. 9..
//
//

import UIKit
import MediaPlayer
import MobileCoreServices
import RealmSwift


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
    
    @IBOutlet weak var TimeTextField: UITextField!
    var seconds: Double = 0
    @IBAction func PlayButton(_ sender: Any) {
        
        
        
        //텍스트 필드에 입력한 숫자를
        guard let perSecond = Double(TimeTextField.text!) else {
            print("입력된 숫자가 없거나 잘못된 값이 입력되었습니다.")
            
            
            return
        }
        
        //시간초기화
        self.seconds = 0
        //이전타이머를 초기화합니다.
        self.timer.invalidate()
        
        //타이머를 생성해줍니다.
        //반복하는 타이머이며 반복주기는 1초입니다.
        self.timer = Timer.scheduledTimer(timeInterval: perSecond, target: self, selector: #selector(timerResult), userInfo: nil, repeats: true)
        
        //타이머의 트리거를 당깁니다. 빵야
        self.timer.fire()
        
        




}
  }
