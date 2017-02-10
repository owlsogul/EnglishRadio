//
//  CountryViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {

    
    let country: [String] = ["Canada", "United States", "Australia", "United Kingdom"]
    
    var arrangedCountry: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorStyle = .none
       
        arrangedCountry = country.sorted(by: {(left:String, right:String) -> Bool
            in return left < right})
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func NavigationBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }

    
    //row 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return country.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CountryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryTableViewCell
        
        let rowNumber:Int = indexPath.row
        let name: String = country[rowNumber]
            
        
        
        cell.backgroundColor = UIColor.clear
        
        cell.countryLabel?.textColor = UIColor.white.withAlphaComponent(0.9)
        cell.countryLabel?.text = name
        
        print("country 탭에 셀이 생성되었다")
       
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CountryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryTableViewCell
        if cell.isSelected {
            cell.setSelected(true, animated:true)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
        
        
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        
        
        
    }
    

}
