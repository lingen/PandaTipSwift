//
//  ViewController.swift
//  T
//
//  Created by 刘林 on 2017/8/11.
//  Copyright © 2017年 刘林. All rights reserved.
//

import UIKit
import PandaTip

class ViewController: UIViewController {

    var pandaTip:PandaTip = PandaTip()
    
    var textView:UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpView()
    }


    private func setUpView(){
        let button = UIButton(type: .system)
        button.setTitle("弹出一个信息", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        self.view.addSubview(button)
        let action = #selector(ViewController.showInfo)
        button.addTarget(self, action: action, for: .touchDown)
        
        
        let button2 = UIButton(type: .system)
        button2.setTitle("弹出一个错误", for: .normal)
        button2.frame = CGRect(x: 100, y: 150, width: 100, height: 40)
        self.view.addSubview(button2)
        let action2 = #selector(ViewController.showError)
        button2.addTarget(self, action: action2, for: .touchDown)
        
        
        let button3 = UIButton(type: .system)
        button3.setTitle("弹出一个警告", for: .normal)
        button3.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        self.view.addSubview(button3)
        let action3 = #selector(ViewController.showWarn)
        button3.addTarget(self, action: action3, for: .touchDown)
    }
    
    @objc func showInfo(){
        pandaTip.showInfoTip(msg: "这是一个弹出信息，我的文字很长很丰南区这是一个弹出信息，我的文字很长很丰南区这是一个弹出信息，我的文字很长很丰南区这是一个弹出信息，我的文字很长很丰南区这是一个弹出信息")
    }
    
    @objc func showError(){
        pandaTip.showErrorTip(msg: "这是一个错误弹框")
    }
    
    
    @objc func showWarn(){
        pandaTip.showWarnTip(msg: "这是一个警告弹框")
    }
}

