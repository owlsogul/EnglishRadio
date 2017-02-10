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
    
    var favStationInfos: Results<StationInfo>?
    // ViewController의 화면이 보여지기 직전에 불려질 함수
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController의 화면이 보여질 예정입니다")
        
        // Realm을 초기화하여 realm 이라는 이름으로 사용합니다
        let realm = try? Realm()
        
        // PhotoInfo에 해당하는 자료들을 데이터베이스에서 불러와서 photoInfos에 넣어줍니다
        self.favStationInfos = realm?.objects(StationInfo.self)
        
        // 테이블뷰를 새로고침 합니다
        // > 테이블뷰를 새로고침하면 테이블뷰가 보스에게 다시 row의 개수와 데이터를 요청합니다
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
            
            /*
            if let imageData = info.imageData {
                cell.imageView?.image = UIImage(data: imageData, scale: 0.1)
            }
            */
            
            // cell의 detailTextLabel에 세팅
            cell.detailTextLabel?.text = info.stationCountry
        }
        
        return cell
    }
    
    
    //    // ADDIMAGEVIEWCONTROLLER가 화면에 보이기 직전에 수행할 일을 넣어줍니다.
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //
    //        // 이전화면에서 넘어온 정보가 있을지 없을지 모르기 때문에 옵셔널을 추출해봅니다.
    //        if let info = self.stationInfoFromPrevController {
    //
    //            //사진정보를 title을 제목 필드에 세팅
    //            self.titleField.text = info.title
    //
    //            if let imageData = info.imageData {
    //                self.selectedImage?.image = UIImage(data: imageData, scale: 1.0)
    //
    //            }
    //        }
    
    
    
}



