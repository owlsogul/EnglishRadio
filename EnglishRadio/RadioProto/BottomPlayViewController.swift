//
//  BottomPlayViewController.swift
//  RadioProto
//
//  Created by byung-soo kwon on 2017. 2. 12..
//  Copyright © 2017년 byung-soo kwon. All rights reserved.
//

import UIKit

class BottomPlayViewController: UIViewController {

    /**viewDidLoad함수에 모달창 배경 투명하게하는 옵션을 넣음*/
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        super.viewDidLoad()

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
