//
//  UILoadingView.swift
//  PandaTip
//
//  Created by 刘林 on 2017/8/12.
//  Copyright © 2017年 刘林. All rights reserved.
//

import UIKit

class UILoadingView: UIView {
    
    var loadingIndicatorView:UIActivityIndicatorView?
    
    init(){
        super.init(frame: CGRect.zero)
        setUpView()
        layoutLoadingIndicatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func stopLoading(){
        loadingIndicatorView?.stopAnimating()
    }
    
    public func startLoading(){
        loadingIndicatorView?.startAnimating()
    }
    
    private func setUpView(){
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        if loadingIndicatorView == nil {
            loadingIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.addSubview(loadingIndicatorView!)
        }
    }
    
    
    private func layoutLoadingIndicatorView(){
        loadingIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centerY = NSLayoutConstraint(item: loadingIndicatorView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        let width = NSLayoutConstraint(item: loadingIndicatorView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        let height = NSLayoutConstraint(item: loadingIndicatorView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40)
        self.addConstraints([centerX,centerY,width,height])
    }
    
    
}
