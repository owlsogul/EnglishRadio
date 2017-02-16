//
//  BottomPlayViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 12..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit
import RealmSwift

class BottomPlayViewController: UIViewController {
    
    var stationInfos: Results<StationInfo>?
    var currentStation: StationData!

    @IBOutlet weak var stationInfoView: UIView!
    
    @IBOutlet weak var albumArtImageView: UIImageView!
    
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationGenreLabel: UILabel!
    @IBOutlet weak var stationCountryLabel: UILabel!
    @IBOutlet weak var stationStatesLabel: UILabel!
    @IBOutlet weak var stationDescriptionLabel: UILabel!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("ViewController의 화면이 보여질 예정입니다")

        
        
        let stationInfos : StationInfo = StationInfo()
        self.stationCountryLabel.textColor = UIColor.black
        self.stationCountryLabel?.text = stationInfos.stationCountry
        print("\(stationInfos.stationCountry)")
        print("\(currentStation?.getStationName())")
        print("라벨이 로드되었다")
        
        
        self.stationInfoView.reloadInputViews()
        
    }
    
    /**viewDidLoad함수에 모달창 배경 투명하게하는 옵션을 넣음*/
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        
        
        
        
        
        //self.albumArtImageView? = stationInfos.stationData
        
        /*self.stationNameLabel?.text = stationInfos.stationData
        self.stationGenreLabel?.text = stationInfos.stationData*/
        
        //self.stationStatesLabel?.text = stationInfos.stationData
        //self.stationDescriptionLabel?.text = stationInfos.stationData
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Back(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
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
