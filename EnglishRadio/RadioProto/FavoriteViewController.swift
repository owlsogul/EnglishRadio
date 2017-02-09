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
    
    var stationInfoFromPrevController: StationInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //테이블 뷰 백그라운드 색상 및 구분선 UI 조작
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("보스, 1 번째 색션은 줄을 몇개를 보여줘야 하나요?)")
        
        return 10
        // 무엇을 보여줄지 알려주는 함수
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
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



