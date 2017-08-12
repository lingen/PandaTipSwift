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
    
    func update(msg:String,icon:TipImage){
        titleView?.text = msg
        if icon.image() != nil {
            iconView?.image = icon.image()
        }
    }
    
    // MARK: View元素初始化
    private func setUpView(){
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        if iconView == nil {
            iconView = UIImageView(image: UIImage(named: INFO_ICON))
            self.addSubview(iconView!)
        }
        
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textColor = UIColor.white
            titleView?.numberOfLines = 0
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
        
        let centerY = iconView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        
        let leading = iconView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        
        let width = iconView?.widthAnchor.constraint(equalToConstant: 25)
        
        let height = iconView?.heightAnchor.constraint(equalToConstant: 25)
        
        NSLayoutConstraint.activate([centerY!,leading!,width!,height!])
        
    }
    
    private func layoutTitleView(){
        titleView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            (titleView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0))!,
            (titleView?.leadingAnchor.constraint(equalTo: (self.iconView?.trailingAnchor)!, constant: 10))!,
            (titleView?.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10))!,
            (titleView?.heightAnchor.constraint(greaterThanOrEqualToConstant: 15))!
        ])
    }
    
    
    func estimateHeight(width:CGFloat) -> CGSize {
        var size = CGRect();
        let text:String? = titleView?.text
        let font:UIFont = (titleView?.font!)!
        size = text!.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil);
        
        var height_ = size.height
        
        if height_ < 30 {
            height_ = 30
        }
        
        return CGSize(width: size.width, height: height_)
    }
    
    // MARK: 对外公开的方法
    public func setTextColor(color:UIColor){
        titleView?.textColor = color
    }
    
    public func setBackgroundColor(color:UIColor){
        self.backgroundColor = color
    }
}
