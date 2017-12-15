//
//  FirstViewController.swift
//  NavigationControllerDemo
//
//  Created by lokizero00 on 2017/12/13.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController ,ParameterDelegate{
    @IBOutlet weak var nextParamText:UITextField!
    @IBOutlet weak var preParamLabel:UILabel!
    @IBOutlet weak var preParamTypeLabel:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="xib页面1"
        self.view.backgroundColor=UIColor.white
        
        //设置导航栏右按钮
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goNext))
    }
    
    //由ParameterDelegate实现的代理回传参数方法
    func passParam(_preParam: String,_preParamType:String){
        if _preParam != "" {
            preParamLabel.text=_preParam
            preParamTypeLabel.text=_preParamType
        }else{
            preParamLabel.text="暂无"
            preParamTypeLabel.text=""
        }
    }
    
    @objc func goNext(){
        let secondCtl=SecondViewController(nibName: "SecondViewController", bundle: nil)
        secondCtl.preParam=nextParamText.text!
        secondCtl.preParamType="正向传值"
        //将目标controller的代理设置成自身，并实现其代理，然后再代理方法中写好参数接收代码，方便反向代理传值
        secondCtl.delegate=self
        self.navigationController?.pushViewController(secondCtl, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
