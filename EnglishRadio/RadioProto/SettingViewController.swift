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
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //테이블 뷰 백그라운드 색상 및 구분선 UI 조작
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
        
      
        //데이터테이블 스위치로 hide&Show 조작
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        
        
        
//        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 4
        
    }
    

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
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
            
            

            return cell
            
        } else {
            
            print("테이블은 언제 불러오죠?")
            let cell:SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataLimitCell", for: indexPath) as! SettingTableViewCell
            
            cell.backgroundColor = UIColor.clear
            if changed{
                print("안숨김")
                cell.isHidden = false
                return cell

            }else {
                print("숨김")
                cell.isHidden = true
                return cell

                
            }
            
         
            
        
            
        }
    
    }

    
    
    // 왜 에러가 나냐 이거에요ㅠㅠㅠㅠㅠ ㅗㅗ
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell : SettingTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as! SettingTableViewCell
    print("언제 호출이 되는걸까요")
    
    if cell.dataSettingSwitch.isOn{
    
        if indexPath.row == 3 {
            
            return 144
            
        }
    }else  {
        
        if indexPath.row == 3 {
        
           return 144
        }
    }
    
    return UITableViewAutomaticDimension
    }
 

    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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
    

    
    @IBAction func toggleDataButton(_ sender: UISwitch) {
        
        if sender.isOn {
           
            changed = true
            tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)
            
             print("reload")
              } else {
            
            changed = false
            tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)
            
            print("reload")
        
        }
        
    }
    
    
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
