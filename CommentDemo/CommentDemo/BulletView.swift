//
//  BulletView.swift
//  CommentDemo
//
//  Created by 叶世昌 on 2018/10/22.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

enum MoveStatus {
    case start
    case enter
    case end
}

class BulletView: UIView {
    
    let Padding: CGFloat = 10.0
    let PhotoHeight: CGFloat = 30.0

    /// 弹道
    var trajectory: Int?
    /// 弹幕状态回调
    var moveStatusBlock: ((_ status: MoveStatus) -> ())?
    
    /// 初始化
    convenience init(frame: CGRect, comment: NSString) {
        
        self.init(frame: frame)
        // 计算弹幕s的实际宽度
        let attr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        let width = comment.size(withAttributes: attr).width
        bounds = CGRect.init(x: 0, y: 0, width: width + 2 * Padding + PhotoHeight, height: 30)
        
        lbComment.text = comment as String
        lbComment.frame = CGRect.init(x: Padding + PhotoHeight, y: 0, width: width, height: 30)
        photoIgv.frame = CGRect.init(x: -Padding, y: -Padding, width: PhotoHeight + Padding, height: PhotoHeight + Padding)
        photoIgv.layer.cornerRadius = (PhotoHeight + Padding)/2
        photoIgv.layer.borderColor = UIColor.orange.cgColor
        photoIgv.layer.borderWidth = 1
        photoIgv.image = UIImage.init(named: "like_click")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(lbComment)
        backgroundColor = UIColor.red
        layer.cornerRadius = Padding/3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 开始动画
    func startAnimation() {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let duration: CGFloat = 4.0
        let wholeWidth = screenWidth + bounds.width
        
        moveStatusBlock?(.start)
        
        let speed = wholeWidth/duration
        let enterDuration = bounds.width/speed
        
        perform(#selector(delayAction), with: nil, afterDelay: TimeInterval(enterDuration))
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: [.curveLinear], animations: {
            self.frame.origin.x -= wholeWidth
        }) { (finished) in
            self.removeFromSuperview()
            self.moveStatusBlock?(.end)
        }
    }
    /// 结束动画
    func stopAnimation() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        layer.removeAllAnimations()
        removeFromSuperview()
    }
    
    @objc func delayAction() {
        self.moveStatusBlock?(.enter)
    }
    
    private lazy var lbComment: UILabel = {
       
        let lb = UILabel.init(frame: CGRect.zero)
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .center
        return lb
    }()
    
    private lazy var photoIgv: UIImageView = {
        let igv = UIImageView.init()
        igv.clipsToBounds = true
        igv.contentMode = .scaleAspectFill
        addSubview(igv)
        return igv
    }()
}
