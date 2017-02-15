//
//  FavouriteTableTableViewController.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 9..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import RealmSwift


class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bottomTableView: UITableView!
  
    var recievedStationName: String?
    var isPlaying: Bool = true
    //###################################################
    // MARK: -  액션 모음
    //###################################################
    
    
    @IBAction func clickEditButton(_ sender: UIButton) {
        if (self.tableView.isEditing) {
            editButton.setTitle("Edit", for: UIControlState.normal)
            self.tableView.setEditing(false, animated: true)
        } else {
            editButton.setTitle("Done", for: UIControlState.normal)
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    //###################################################
    // MARK: - 뷰 로딩 설정
    //###################################################
    
    // ViewController의 화면이 보여지기 직전에 불려질 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController의 화면이 보여질 예정입니다")
        
        // Favorite Manager의 Realm으로부터 Result 값을 불러옵니다
        ViewController.favManager.load()
        
        // 테이블뷰를 새로고침 합니다
        self.tableView.reloadData()
       self.bottomTableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        bottomTableView.backgroundColor = UIColor.clear
        bottomTableView.separatorStyle = .none
        

        //테이블 뷰 백그라운드 색상 및 구분선 UI 조작
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorStyle = .none
      
    }

    
    //###################################################
    // MARK: -  테이블 뷰 세팅
    //###################################################
    
    
    // 테이블뷰의 셀을 스와이프하여 삭제할 수 있는지 확인
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // 테이블뷰의 셀을 스와이프하여 삭제할 수 있도록 옵션 제공
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    // 테이블뷰의 셀을 스와이프하여 삭제할 때 호출되는 함수
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 삭제할 정보를 꺼내와서
        if let deletingInfo = ViewController.favManager.favStationArr?[indexPath.row] {
            
            // Realm에서 삭제해줍니다
            ViewController.favManager.delFavorite(id: deletingInfo.favoriteID)
            
            // 실제 테이블뷰에서 row를 삭제합니다
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            ViewController.favManager.load()
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // favStationInfos는 옵셔널ㅇㅇ
        
        if tableView == self.tableView{
        return ViewController.favManager.favStationArr?.count ?? 0
    
        }
        
        return 1
    
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        // cell의 indexPath의 row에 해당하는 스테이션 정보를 불러옴
        if let info = ViewController.favManager.favStationArr?[indexPath.row] {
            
            cell.backgroundColor = UIColor.clear
            // 스테이션데이터(스테이션이름)을 텍스트라벨에 적용
            cell.textLabel?.text = info.stationData
            cell.textLabel?.textColor = UIColor.white
            
            /* 아직 이미지부분은 구현ㄴㄴ >>> 주석처리 합니다
            if let imageData = info.imageData {
                cell.imageView?.image = UIImage(data: imageData, scale: 0.1)
            }
            */
            
            // cell의 detailTextLabel에 세팅
            cell.detailTextLabel?.text = info.stationCountry
            cell.detailTextLabel?.textColor = UIColor.white
        }
        
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        
        
        return cell
        }else {
            
            
            let cell: BottomPlayViewCell = tableView.dequeueReusableCell(withIdentifier: "bottomPlayCell", for: indexPath) as! BottomPlayViewCell
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            
            //만약 현재 플레이 중이라면
            if ViewController.nowPlaying{
                
                //Bottom 셀의 hidden 을 해제하고 현재 재생중인 스테이션 제목을 보여준다.
                cell.bottomStationLabel.text = ViewController.stationName
                cell.bottomStationLabel.textColor = UIColor.white
                cell.bottomPlayButton.setImage(#imageLiteral(resourceName: "newPauseSmall"), for: .normal)
                cell.isHidden = false
                
                return cell
            }else {
                
                // 아니라면 그냥 놔두고 아이콘만 변경
                cell.isHidden = true
                return cell
            }
            
    }
        
    }
    
    
    
    
    
    
    
}



    


    



