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
    
    
    @IBAction func clickEditButton(_ sender: UIButton) {
        if (self.tableView.isEditing) {
            editButton.setTitle("Edit", for: UIControlState.normal)
            self.tableView.setEditing(false, animated: true)
        } else {
            editButton.setTitle("Done", for: UIControlState.normal)
            self.tableView.setEditing(true, animated: true)
        }
    }
    
    var favStationInfos: Results<StationInfo>?
    // ViewController의 화면이 보여지기 직전에 불려질 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController의 화면이 보여질 예정입니다")
        
        // Realm을 초기화하여 realm 이라는 이름으로 사용합니다
        let realm = try? Realm()
        
        // StationInfo에 해당하는 자료들을 데이터베이스에서 불러와서 favStationInfos에 넣어줍니다
        self.favStationInfos = realm?.objects(StationInfo.self)
        
        // 테이블뷰를 새로고침 합니다
        self.tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //테이블 뷰 백그라운드 색상 및 구분선 UI 조작
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0

        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // photoInfos는 옵셔널이므로 옵셔널에 값이 없으면 0을 돌려주세요
        return self.favStationInfos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        // cell의 indexPath의 row에 해당하는 사진 정보를 가져와 봅니다
        if let info = self.favStationInfos?[indexPath.row] {
            
            cell.backgroundColor = UIColor.clear
            // 사진정보의 title을 텍스트 레이블에 세팅
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
        
        return cell
    }
    
    /*
    private func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = tableData[fromIndexPath.row]
        tableData.removeAtIndex(fromIndexPath.row)
        tableData.insert(itemToMove, atIndex: toIndexPath.row)
        
    }
    
    */
    
    
    
    
    

    
}



