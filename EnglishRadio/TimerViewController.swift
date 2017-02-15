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
        timer?.invalidate()
        
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
    
    
    @IBAction func ClearButton(_ sender: UIButton!) {
        
        // 테이블에 있는 데이터들 지우기
    }
    
    
    @IBOutlet weak var TimeTextField: UITextField!
    //    var seconds: Double = 0
    let radioPlayer = MPMoviePlayerController()
    var second: TimeInterval = 0
    
    @IBOutlet weak var PlayButton: UIButton!
    var isPlay: Bool = false
    var currentStation: StationData!
    var firstPlay: Bool = true
    var timer: Timer?
    
    @IBAction func play(sender: UIButton){
        
        //만약 처음으로 실행한 것이 아니면
        if firstPlay == true {
            //            if chooseRandomStation() {
            //                print("스테이션이 없습니다")
            //            }
            firstPlay = false
        }
        
        
        self.second = 0
        //이전타이머를 초기화합니다.
        self.timer?.invalidate()
        self.timer = nil
        
        
        if isPlay == false {
            
            if let text = self.TimeTextField.text, let perSecond = TimeInterval(text) {
                
                //타이머를 생성해줍니다.
                //반복하는 타이머이며 반복주기는 1초입니다.

                self.timer = Timer.scheduledTimer(timeInterval: perSecond, target: self, selector: #selector(timerResult), userInfo: nil, repeats: true)
                //타이머의 트리거를 당깁니다. 빵야
                self.timer?.fire()
                
                
                // 라디오를 재생해줌
                
                //        radioSetting()
                //        radioPlay()
                //
                //        refreshMainInfo()
                //        playButton.setImage(#imageLiteral(resourceName: "newPause"), for: .normal)
                //
                //        updateLockScreen()
                
                
                
                isPlay = true
            }
            
        } else {    // 재생중이라면
           
            radioPlayer.stop()
            isPlay = false
        }
        
        
        
    }
    
}
