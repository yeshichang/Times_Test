//
//  ViewController.swift
//  CommentDemo
//
//  Created by 叶世昌 on 2018/10/22.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var manager: BulletManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = BulletManager()
        manager?.datasource = ["弹幕1~~~~~~~",
                               "弹幕2~~~~~~~~~~~",
                               "弹幕3~~~~~~~~",
                               "弹幕4~~~~~~~~~",
                               "弹幕5~~~~~~~~~~~",
                               "弹幕6~~~~~~",
                               "弹幕7~~~",
                               "弹幕8~~~~~~~~",
                               "弹幕9~~~~~~",]
        manager?.generateViewBlock = { bulletView in
            self.add(bulletView: bulletView)
        }
    }

    @IBAction func startCommentAct(_ sender: Any) {
        manager?.start()
    }
    @IBAction func stopCommentAct(_ sender: Any) {
        manager?.stop()
    }
    
    func add(bulletView view: BulletView) {
        let width = UIScreen.main.bounds.size.width
        view.frame = CGRect.init(x: width, y: CGFloat(300 + view.trajectory! * 50), width: view.bounds.size.width, height: view.bounds.size.height)
        self.view.addSubview(view)
        view.startAnimation()
    }
    
}

