//
//  ViewController.swift
//  NavigationControllerDemo
//
//  Created by lokizero00 on 2017/12/13.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit

class StoryBoard1ViewController: UIViewController {
    @IBOutlet weak var nextParamText:UITextField!
    @IBOutlet weak var preParamLabel:UILabel!
    @IBOutlet weak var preParamTypeLabel:UILabel!
    
    var preParam:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="StoryBoard1"
        
        //注册通知，供通知式参数传值使用
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveParam(title:)), name: NSNotification.Name(rawValue: "SB01Notify"), object: nil)
    }
    
    //通知传值的接收方法
    @objc func receiveParam(title:NSNotification){
        let dic=title.userInfo! as NSDictionary
        let param=dic.object(forKey: "param") as? String
        let paramType=dic.object(forKey: "type") as? String
        if param != ""{
            preParamLabel.text=param
            preParamTypeLabel.text=paramType
        }else{
            preParamLabel.text="暂无"
            preParamTypeLabel.text=""
        } 
    }
    
    @IBAction func goNext(_ sender: UIBarButtonItem) {
        let sb02=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SB02") as! StoryBoard2ViewController
        sb02.preParam=nextParamText.text
        sb02.preParamType="正向传值"
        self.present(sb02, animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {
            () -> Void in
            let dic:[String:String]=[
                "param":self.nextParamText.text!,
                "type":"通知传值"
            ]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SecondNotify"), object: nil, userInfo: dic)
        })
    }
    
    //segue传值，好像只能在StoryBoard上使用
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShow" {
            let vc=segue.destination as! StoryBoard2ViewController
            vc.preParam=nextParamText.text
            vc.preParamType="segue传值"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SB01Notify"), object: nil)
    }
    
    
//    @objc func receiveParam(title:Notification){
//        preParamLabel.text=title.object as? String
//    }

}

