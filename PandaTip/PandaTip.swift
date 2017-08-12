//
//  PandaTip.swift
//  T
//
//  Created by 刘林 on 2017/8/11.
//  Copyright © 2017年 刘林. All rights reserved.
//

import UIKit

public class PandaTip {
    
    public static var DEFAULT_TEXT_COLOR = UIColor.white
    
    public static var DEFAULT_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    
    var textColor:UIColor?
    
    var backgroundColor:UIColor?
    
    var tipPosition:TipPosition = TipPosition.Top
    
    var loadingView:UILoadingView?
    
    var tipView:UITipView?
    
    public init() {
        
    }
    
    public init(tipPosition:TipPosition) {
        self.tipPosition = tipPosition
    }
    
    public init(tipPosition:TipPosition,textColor:UIColor,backgroundColor:UIColor) {
        self.tipPosition = tipPosition
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    
    public func show(){
        if loadingView == nil {
            loadingView = UILoadingView()
            loadingView?.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
        }
        
        loadingView?.startLoading()
        
        let window = UIApplication.shared.windows[0]
        window.addSubview(loadingView!)
        window.bringSubview(toFront: loadingView!)
        
        UIView.animate(withDuration: 0.5) {
            self.loadingView?.frame = CGRect(x: (UIScreen.main.bounds.width - 80) / 2, y: (UIScreen.main.bounds.height - 80) / 2, width: 80, height: 80)
        }
    }
    
    public func dismiss(){
        loadingView?.stopLoading()
        
        UIView.animate(withDuration: 0.4, animations: {
            self.loadingView?.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
        }) { (result) in
            self.loadingView?.removeFromSuperview()
        }
    }
    
    public func showInfoTip(msg:String) {
        show(msg:msg,icon:TipImage.InfoIcon)
    }

    public func showErrorTip(msg:String) {
        show(msg:msg,icon:TipImage.ErrorIcon)
    }
    
    public func showWarnTip(msg:String) {
        show(msg:msg,icon:TipImage.WarnIcon)
    }
    
    public func show(msg:String,icon:TipImage){
        if tipView == nil {
            tipView = UITipView()
        }
        tipView?.update(msg: msg, icon: icon)
        if textColor != nil {
            tipView?.setTextColor(color: textColor!)
        }
        
        if backgroundColor != nil {
            tipView?.setBackgroundColor(color: backgroundColor!)
        }
        
        tipView?.frame = self.tipPosition.hiddenFrame(tip:tipView!)
        let window = UIApplication.shared.windows[0]
        window.addSubview(tipView!)
        window.bringSubview(toFront: tipView!)
        
        UIView.animate(withDuration: 0.3) {
            self.tipView?.frame = self.tipPosition.showFrame(tip: self.tipView!)
        }
        
        DispatchQueue.main.asyncAfter(deadline:  .now() + 1.5) {
            UIView.animate(withDuration: 0.3, animations: {
                self.tipView?.frame = self.tipPosition.hiddenFrame(tip:self.tipView!)
            }, completion: { (result) in
                self.tipView?.removeFromSuperview()
            })
        }
    }
}

public enum TipPosition {
    private var STATUS_BAR_HEIGHT:CGFloat {
        return 20.0
    }

    private var DEVICE_WIDTH:CGFloat {
        return UIScreen.main.bounds.width
    }
    
    private var DEVICE_HEIGHT:CGFloat {
        return UIScreen.main.bounds.height
    }
    case Top
    case Middle
    case Bottom
    
    func showFrame(tip:UITipView) -> CGRect {
        switch self {
        case .Top:
            let height = tip.estimateHeight(width: DEVICE_WIDTH - 80).height
            return CGRect(x: 0, y: STATUS_BAR_HEIGHT, width:DEVICE_WIDTH, height: height)
        case .Bottom:
            let height = tip.estimateHeight(width: DEVICE_WIDTH - 80).height
            return CGRect(x: 0, y: DEVICE_HEIGHT - height, width:DEVICE_WIDTH, height: height)
        case .Middle:
            let size = tip.estimateHeight(width: DEVICE_WIDTH - 80)
            let height = size.height + 20
            let width  = size.width + 80 //add icon's width
            return CGRect(x: (DEVICE_WIDTH - width) / 2, y: (DEVICE_HEIGHT - height ) / 2, width:width, height: height)
        }
    }
    
    func hiddenFrame(tip:UITipView) -> CGRect {
        switch self {
        case .Top:
            let height = tip.estimateHeight(width: DEVICE_WIDTH - 80).height
            return CGRect(x: 0, y: 0 - height, width:DEVICE_WIDTH, height: height)
        case .Bottom:
            let height = tip.estimateHeight(width: DEVICE_WIDTH - 80).height
            return CGRect(x: 0, y: DEVICE_HEIGHT, width:DEVICE_WIDTH, height: height)
        case .Middle:
            return CGRect(x: DEVICE_WIDTH / 2, y: DEVICE_HEIGHT / 2, width:0, height: 0)
        }
    }
}
