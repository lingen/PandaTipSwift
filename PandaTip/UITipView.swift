//
//  TipUIView.swift
//  T
//
//  Created by 刘林 on 2017/8/11.
//  Copyright © 2017年 刘林. All rights reserved.
//

import UIKit

public enum TipImage {
    case InfoIcon
    case WarnIcon
    case ErrorIcon
    case OtherIcon(name:String)
    
    public func image() -> UIImage? {
        switch self {
        case .InfoIcon:
            let pandanTipBundle = Bundle(identifier: "org.openpanda.PandaTip")
            return UIImage(named: "info", in: pandanTipBundle, compatibleWith: nil)
        case .ErrorIcon:
            let pandanTipBundle = Bundle(identifier: "org.openpanda.PandaTip")
            return UIImage(named: "error", in: pandanTipBundle, compatibleWith: nil)
        case .WarnIcon:
            let pandanTipBundle = Bundle(identifier: "org.openpanda.PandaTip")
            return UIImage(named: "warn", in: pandanTipBundle, compatibleWith: nil)
        case .OtherIcon(let name):
            return UIImage(named:name)
        }
    }
}

class UITipView: UIView {
    
    private let INFO_ICON = "info"
    
    private let ERROR_ICON = "error"
    
    private let WARN_ICON = "warn"
    
    var iconView:UIImageView?
    
    var titleView:UILabel?
    
    var msg:String?
    
    var icon:UIImage?
    
    init(msg:String,icon:TipImage) {
        self.msg = msg
        self.icon = icon.image()
        super.init(frame: CGRect.zero)
        setUpView()
        layoutViews()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setUpView()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: View元素初始化
    private func setUpView(){
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        if iconView == nil {
            if icon != nil {
                iconView = UIImageView(image: icon!)
            }else{
                iconView = UIImageView(image: UIImage(named: INFO_ICON))
            }
            self.addSubview(iconView!)
        }
        
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textColor = UIColor.white
            titleView?.numberOfLines = 0
            titleView?.text = msg
            self.addSubview(titleView!)
        }
    }
    
    private func layoutViews(){
        layoutIconView()
        layoutTitleView()
    }
    
    // MARK: View布局约束
    private func layoutIconView(){
        iconView?.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = NSLayoutConstraint(item: iconView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: iconView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
        
        let width = NSLayoutConstraint(item: iconView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
        
        let height = NSLayoutConstraint(item: iconView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 25)
        
        self.addConstraints([centerY,leading,width,height])
    }
    
    private func layoutTitleView(){
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = NSLayoutConstraint(item: titleView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
        let leading = NSLayoutConstraint(item: titleView!, attribute: .leading, relatedBy: .equal, toItem: iconView, attribute: .trailing, multiplier: 1.0, constant: 10)
        
        let trailing = NSLayoutConstraint(item: titleView!, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
        
        let height = NSLayoutConstraint(item: titleView!, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 15)
        
        self.addConstraints([centerY,leading,trailing,height])
    }
    
    
    func estimateHeight(width:CGFloat) -> CGSize {
        var size = CGRect();
        let text:String? = titleView?.text
        let font:UIFont = (titleView?.font!)!
        size = text!.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil);
        
        var width_ = size.width
        var height_ = size.height
        
        if width_ < 30 {
            width_ = 30
        }
        
        if height_ < 30 {
            height_ = 30
        }
        
        return CGSize(width: width_, height: height_)
    }
    
    // MARK: 对外公开的方法
    public func setTextColor(color:UIColor){
        titleView?.textColor = color
    }
    
    public func setBackgroundColor(color:UIColor){
        self.backgroundColor = color
    }
}
