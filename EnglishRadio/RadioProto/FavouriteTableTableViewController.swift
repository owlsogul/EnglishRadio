//
//  FavouriteTableTableViewController.swift
//  RadioProto
//
//  Created by CAUADC on 2017. 2. 9..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import RealmSwift


class FavouriteTableTableViewController: UITableViewController {
    
    
    
    func FavouriteTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("보스, 1 번째 색션은 줄을 몇개를 보여줘야 하나요?)")
        
        return self.stationNames.count
        
        // 무엇을 보여줄지 알려주는 함수
        func favouriteTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            
        }
        
        
        
        
        
    }
}



