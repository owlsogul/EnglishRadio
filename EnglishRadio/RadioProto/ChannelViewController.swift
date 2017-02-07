//
//  ChannelViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 7..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableView.separatorInset.left = 0
        
    }

    @IBAction func NavigationBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stationListCell", for: indexPath) as! ChannelTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.stationLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
        cell.stationLabel?.text = "Station Name"
        

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
