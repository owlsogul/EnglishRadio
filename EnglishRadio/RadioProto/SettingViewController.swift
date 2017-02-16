//
//  SettingViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 6..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var changed:Bool = false
    var currentIndex: Int = 0
    var isPlaying:Bool = true
    var radioPlayer:RadioPlayer = RadioPlayer()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomTableView: UITableView!
    
    
    //###################################################
    // MARK: - 뷰 로딩 설정
    //###################################################
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
       /**테이블 뷰 백그라운드 색상 및 구분선 UI 조작*/
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0

        /**데이터테이블 스위치로 hide&Show 조작*/
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        bottomTableView.backgroundColor = UIColor.clear
        bottomTableView.separatorStyle = .none
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.bottomTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    
    //###################################################
    // MARK: - Setting 테이블 설정하기
    //###################################################
    
    
    
    /** Setting 테이블의 줄(row)갯수 정하기*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.tableView{
        return 4
        }
        else{
            return 1
        }
        
    }
    
    /**줄마다 테이블셀 설정*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if tableView == self.tableView {
      
            print("section number is \(indexPath.section)")
        
        //첫번째 row 에 country
        if indexPath.row == 0 {
            
            let cell:SettingTableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! SettingTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.countryLabel?.textColor = UIColor.white
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.countryLabel?.text = "Country"
            print("section1")
            
            return cell
        
        //두번째 row에 channel
        }else if indexPath.row == 1 {
            
            let cell:SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as! SettingTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.channelLabel?.textColor = UIColor.white
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.channelLabel?.text = "Channel"
            
            return cell
        
        //세번째 row에 data
        }else if indexPath.row == 2{
            
            let cell:SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! SettingTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.dataLabel?.textColor = UIColor.white
            cell.dataLabel?.text = "3G/LTE"

            cell.dataSettingSwitch.onTintColor = UIColor.white.withAlphaComponent(0.8)
            cell.dataSettingSwitch.tintColor = UIColor.white
            return cell
            
        } else {
            
            print("테이블은 언제 불러오죠?")
            let cell:SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataLimitCell", for: indexPath) as! SettingTableViewCell
            
            cell.backgroundColor = UIColor.clear
            cell.dataUsageLabel?.text = "Slide to adjust"
            cell.dataUsageLabel.textColor = UIColor.darkGray.withAlphaComponent(1)
           
            //만약 스위치의 상태가 변한다면
            if changed{
                
                //셀 숨김을 바꾼다.
                cell.isHidden = false
                return cell

            }else {

                cell.isHidden = true
                return cell

                
            }
            
            }
        }else {
                
                
                let cell: BottomPlayViewCell = tableView.dequeueReusableCell(withIdentifier: "bottomPlayCell", for: indexPath) as! BottomPlayViewCell
                cell.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                
                //만약 현재 플레이 중이라면
            
            if radioPlayer.isPlay{
                    //Bottom 셀의 hidden 을 해제하고 현재 재생중인 스테이션 제목을 보여준다.
                   cell.bottomStationLabel.text = radioPlayer.currentStation?.getStationName()
                    cell.bottomStationLabel.textColor = UIColor.white
                    cell.bottomPlayButton.setImage(#imageLiteral(resourceName: "newPauseSmall"), for: .normal)
                    cell.isHidden = false
                    
                    return cell
            }else {
                
                cell.isHidden = true
                return cell
            }
            
        
        }
    
    }
    
    //###################################################
    // MARK: - 데이터 셀 스위치 on/off 동작
    //###################################################
    
    /**data cell에 스위치on 하면 나오는 dataUsageCell의 높이 설정*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView {
    let cell : SettingTableViewCell
    cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! SettingTableViewCell
    
    if cell.dataSettingSwitch.isOn == false{
        
        if indexPath.row == 3 {
            
            print("이건뭐지")
            
            return 144
        }

            }
        }else {
    
    return 52
        
    }
        return UITableViewAutomaticDimension
    }
    //###################################################
    // MARK: - 데이터 셀 스위치 on/off 동작
    //###################################################

    /**스위치 on/off에 따른 테이블 reload설정*/
    @IBAction func toggleDataButton(_ sender: UISwitch) {
        
        
        //만약 스위치가 온이라면
        if sender.isOn {
           
            //아래로 나타난다.
            changed = true
            tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .bottom)
            
              } else {
            
            
            //다시 위로 접힌다.
            changed = false
            tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .top)
            
            
        }
        
    }
    
    /**country테이블과 channel테이블로 이동하는 네비게이션 함수*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
        if indexPath.row == 0 {
            
            if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "countryView"){
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
        }else if indexPath.row == 1{
            
            if let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "channelView"){
                
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        }
        
        
    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
