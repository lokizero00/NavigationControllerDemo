//
//  SecondViewController.swift
//  NavigationControllerDemo
//
//  Created by lokizero00 on 2017/12/13.
//  Copyright © 2017年 lokizero00. All rights reserved.
//

import UIKit

//创建代理，然后由跳转发起的controller实现，以实现反向代理传值
protocol ParameterDelegate{
    func passParam(_preParam: String,_preParamType:String)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nextParamText:UITextField!
    @IBOutlet weak var preParamLabel: UILabel!
    @IBOutlet weak var preParamTypeLabel:UILabel!
    
    var preParam:String?
    var preParamType:String?
    
    //定义代理
    var delegate:ParameterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="xib页面2"
        self.view.backgroundColor=UIColor.white
        
        self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.goNext))
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.goBack))
        
        //注册通知，供通知式参数传值使用
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveParam(title:)), name: NSNotification.Name(rawValue: "SecondNotify"), object: nil)
    }
    
    //通知式参数接收方法
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
    
    @objc func goBack(){
        if delegate != nil {
            //调用代理方法回传参数
            delegate?.passParam(_preParam: nextParamText.text!, _preParamType: "反向代理传值")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //由于控件在viewDidLoad之后才会加载到内存，所以使用这个方法，在控件加载后再进行赋值
    override func viewWillAppear(_ animated: Bool) {
        if preParam != "" {
            preParamLabel.text=preParam
            preParamTypeLabel.text=preParamType
        }else{
            preParamLabel.text="暂无"
            preParamTypeLabel.text=""
        }
    }
    
    @objc func goNext() {
        //StoryBoard实例化
        let sb01=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SB01") as! StoryBoard1ViewController
        
        //通知传值必须等待跳转完成，并且目标Controller的viewDidLoad方法调用之后再发出通知，否则无效
        self.present(sb01, animated: true, completion: {
            () -> Void in
            let dic:[String:String]=[
                "param":self.nextParamText.text!,
                "type":"通知传值"
            ]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SB01Notify"), object: nil, userInfo: dic)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //使用通知后，必须在销毁前移除通知，否则容易出问题
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SecondNotify"), object: nil)
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
