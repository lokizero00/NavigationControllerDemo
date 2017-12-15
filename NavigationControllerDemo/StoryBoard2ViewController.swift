//
//  StoryBoard2ViewController.swift
//  NavigationControllerDemo
//
//  Created by lokizero00 on 2017/12/14.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit

class StoryBoard2ViewController: UIViewController {
    @IBOutlet weak var preParamLabel:UILabel!
    @IBOutlet weak var preParamTypeLabel:UILabel!
    
    var preParam:String?
    var preParamType:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="StoryBoard2"
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if preParam != nil{
            preParamLabel.text=preParam
            preParamTypeLabel.text=preParamType
        }else{
            preParamLabel.text="暂无"
            preParamTypeLabel.text=""
        }
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
