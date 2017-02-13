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
    var selectedCountry: [String] = []
    var arrangedCountry: [String] = []
    var selectedCell: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorStyle = .none
       
        arrangedCountry = country.sorted(by: {(left:String, right:String) -> Bool
            in return left < right})
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.15)
        tableView.separatorStyle = .none
        

        
        
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
        
        return arrangedCountry.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: CountryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryTableViewCell
        
        let rowNumber:Int = indexPath.row
        let name: String = arrangedCountry[rowNumber]
            
        
        
        cell.backgroundColor = UIColor.clear
        
        cell.countryLabel?.textColor = UIColor.white.withAlphaComponent(0.9)
        cell.countryLabel?.text = name
        
        print("country 탭에 셀이 생성되었다")
       
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.clear
        } else {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CountryTableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "countryListCell", for: indexPath) as! CountryTableViewCell
        if cell.isSelected {
        
            
                //만약 selectedCountry에 현재 선택된 셀의 나라가 없다면 나라를 배열에 넣고 체크마크
                if !selectedCountry.contains(arrangedCountry[indexPath.row]){
                    selectedCountry.append(arrangedCountry[indexPath.row])
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                    tableView.reloadRows(at: [IndexPath.init(row: indexPath.row, section: 0)], with: .none)
                    
                //아니면 체크마크 해제
                }else {
                    for (index, item) in selectedCountry.enumerated(){
                        if item == arrangedCountry[indexPath.row]{
                            selectedCountry.remove(at: index)
                            
                        }
                    }

                    cell.accessoryType = UITableViewCellAccessoryType.none
                    tableView.reloadRows(at: [IndexPath.init(row: indexPath.row, section: 0)], with: .none)
            }
             print(selectedCountry)
        }
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        
        
        
    }
    

}
