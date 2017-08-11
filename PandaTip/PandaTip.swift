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
        let tip = UITipView(msg: msg, icon: icon)
        if textColor != nil {
            tip.setTextColor(color: textColor!)
        }
        
        if backgroundColor != nil {
            tip.setBackgroundColor(color: backgroundColor!)
        }
        
        tip.frame = self.tipPosition.hiddenFrame(tip:tip)
        let window = UIApplication.shared.windows[0]
        window.addSubview(tip)
        window.bringSubview(toFront: tip)
        
        UIView.animate(withDuration: 0.3) {
            tip.frame = self.tipPosition.showFrame(tip: tip)
        }
        
        DispatchQueue.main.asyncAfter(deadline:  .now() + 1.5) {
            UIView.animate(withDuration: 0.3, animations: {
                tip.frame = self.tipPosition.hiddenFrame(tip:tip)
            }, completion: { (result) in
                tip.removeFromSuperview()
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
            return CGRect(x: 0 - DEVICE_WIDTH, y: STATUS_BAR_HEIGHT, width:DEVICE_WIDTH, height: height)
        case .Bottom:
            let height = tip.estimateHeight(width: DEVICE_WIDTH - 80).height
            return CGRect(x: 0, y: DEVICE_HEIGHT, width:DEVICE_WIDTH, height: height)
        case .Middle:
            return CGRect(x: DEVICE_WIDTH / 2, y: DEVICE_HEIGHT / 2, width:0, height: 0)
        }
    }
}
