//
//  CountryViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
     
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CountryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "countryList", for: indexPath) as! CountryTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.stationLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
       
        cell.stationLabel?.text = "radio station"
        
        
        print("country 탭에 셀이 생성되었다")
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
