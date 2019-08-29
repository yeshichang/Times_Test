//
//  ViewController.swift
//  LodingButtonExtension
//
//  Created by 叶世昌 on 2018/11/22.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    let button = UIButton()
    let layer = LMLoadingProgress()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var sss = ["1", "2", "3"]
        print(sss)
        
        sss.swapAt(0, 0)
        
        print(sss)
     
    }
    
    @IBAction func sliderAct(_ sender: UISlider) {
        layer.number = slider.value
    }
    
    func setupLayer() {
        view.layer.addSublayer(layer)
        layer.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
    }
    
    func setupButton() {
        button.setTitle("点我", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.frame = CGRect.init(x: 100, y: 100, width: 200, height: 50)
        button.addTarget(self, action: #selector(btnclick(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
    }

    @objc func btnclick(sender: UIButton) {
 
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.startLoding()
        } else {
            sender.stopLoading()
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nav = UINavigationController.init(rootViewController: LMLocationController())
        present(nav, animated: true, completion: nil)
    }
}


