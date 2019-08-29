//
//  UIButton+Loding.swift
//  LodingButtonExtension
//
//  Created by 叶世昌 on 2018/11/22.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

extension UIButton {
    
    struct RuntimeKey {
        static let jkKey = UnsafeRawPointer.init(bitPattern: "JKKey".hashValue)
        /// ...其他Key声明
    }
    
    var bottomView: UIView? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.jkKey!, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return  objc_getAssociatedObject(self, RuntimeKey.jkKey!) as? UIView
        }
    }
    
    /// 开始旋转动画
    func startLoding() {
        
        bottomView = UIView.init(frame: bounds)
        bottomView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.addSubview(bottomView!)
        
        
        var WH: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        if frame.size.width > frame.size.height {
            WH = frame.size.height
            x = frame.size.width/2 - WH/2
            y = 0
        } else {
            WH = frame.size.width
            x = 0
            y = frame.size.height/2 - WH/2
        }
        x += 5
        y += 5
        WH -= 10

        // 旋转layer
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.orange.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = 5
        ovalShapeLayer.lineCap = .round
        ovalShapeLayer.path = UIBezierPath.init(roundedRect: CGRect.init(x: x, y: y, width: WH, height: WH), byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: WH/2, height: WH/2)).cgPath
        bottomView?.layer.addSublayer(ovalShapeLayer)

//        // 起点动画
//        let strokeStartAnimation = CABasicAnimation.init(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = -1
//        strokeStartAnimation.toValue = 1
//
//        // 终点动画
//        let strokeEndAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0
//        strokeEndAnimation.toValue = 1
//
//        // 组合动画
//        let animationGroup = CAAnimationGroup()
//        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
//        animationGroup.duration = 2
//        animationGroup.repeatCount = Float.greatestFiniteMagnitude
//        animationGroup.fillMode = CAMediaTimingFillMode.forwards
//        animationGroup.isRemovedOnCompletion = false
//        ovalShapeLayer.add(animationGroup, forKey: nil)
    }
    
    /// 结束旋转动画
    func stopLoading() {
        guard let bottomView = bottomView else {
            return
        }
        guard let layers = bottomView.layer.sublayers else {
            return
        }
        for layer in layers {
            layer.removeAllAnimations()
        }
        bottomView.removeFromSuperview()
    }
}

