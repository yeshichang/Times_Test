//
//  BulletManager.swift
//  CommentDemo
//
//  Created by 叶世昌 on 2018/10/22.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

class BulletManager: NSObject {
    
    var generateViewBlock: ((_ view: BulletView) -> Void)?
    
    /// 弹幕的数据来源
    var datasource: [String] = { let datasource = [String](); return datasource }()
    /// 弹幕使用过程中数组变量
    var bulletComments: [String] = { let bulletComments = [String](); return bulletComments }()
    /// 储存弹幕view的数组变量
    var bulletViews: [BulletView] = { let bulletViews = [BulletView](); return bulletViews }()

    var bStopAnimation: Bool = true
    
    func start() {
        if !bStopAnimation {
            return
        }
        bStopAnimation = false
        bulletComments.removeAll()
        bulletComments += datasource
        initBulletComment()
    }
    
    // 初始化弹幕，随机分配弹幕轨迹
    func initBulletComment() {
        if bulletComments.count == 0 {
            return
        }
        var trajectorys = [0, 1, 2]
        for _ in trajectorys {
            // 通过随机数获取到弹幕轨迹
            let index = Int.random(in: 0..<trajectorys.count)
            let trajectory = trajectorys[index]
            trajectorys.remove(at: index)
            
            // 从弹幕数组中逐一去除弹幕数据
            let comment = bulletComments.first
            bulletComments.removeFirst()
            
            // 创建弹幕
            create(bulletView: comment!, trajectory: trajectory)
        }
    }
    
    /// 创建弹幕
    func create(bulletView comment: String, trajectory: Int) {
        if bStopAnimation {
            return
        }
        let view = BulletView.init(frame: CGRect.zero, comment: comment as NSString)
        view.trajectory = trajectory
        bulletViews.append(view)
        view.moveStatusBlock = { [unowned view, self] (status) in
            if self.bStopAnimation {
                return
            }
            switch status {
            case .start:
                self.bulletViews.append(view)
            case .enter:
                if let comment = self.nextComment() {
                    self.create(bulletView: comment, trajectory: trajectory)
                }
            case .end:
                if self.bulletViews.contains(view) {
                    view.stopAnimation()
                    self.bulletViews.removeFirst()
                }
                if self.bulletViews.count == 0 {
                    self.bStopAnimation = true
                    self.start()
                }
            }
            
        }
        self.generateViewBlock?(view)
    }
    
    func nextComment() -> String? {
        if bulletComments.count == 0 {
            return nil
        }
        let comment = bulletComments.first
        if comment != nil {
            self.bulletComments.removeFirst()
        }
        return comment
    }
    
    func stop() {
        if bStopAnimation {
            return
        }
        bStopAnimation = true
        bulletViews.forEach { (bulletView) in
            bulletView.stopAnimation()
        }
        bulletViews.removeAll()
    }
}
