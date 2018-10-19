//
//  ViewController.swift
//  AudioInfo
//
//  Created by 叶世昌 on 2018/10/17.
//  Copyright © 2018 Luomi. All rights reserved.
//



import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func zhendong(_ sender: Any) {
        let deviceModel = UIDevice.current.model
        if deviceModel == "iPhone" {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        } else {
            let alertView = UIAlertView.init(title: "提示", message: "设备不支持震动", delegate: self, cancelButtonTitle: "确定")
            alertView.show()
        }
    }
    @IBAction func playSound(_ sender: Any) {
        let systemSoundUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "咳嗽", ofType: "m4a")!)
        // 创建ID
        var systemSoundId: SystemSoundID = SystemSoundID.init(bitPattern: 0)
        AudioServicesCreateSystemSoundID(systemSoundUrl as CFURL, &systemSoundId)
        // 注册callback
        AudioServicesAddSystemSoundCompletion(systemSoundId, nil, nil, SoundfinishedPlaying, nil)
        // 播放系统声音
        AudioServicesPlaySystemSound(systemSoundId)
    }
    @IBAction func hintSound(_ sender: Any) {
        let systemSoundUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "咳嗽", ofType: "m4a")!)
        // 创建ID
        var systemSoundId: SystemSoundID = SystemSoundID.init(bitPattern: 0)
        AudioServicesCreateSystemSoundID(systemSoundUrl as CFURL, &systemSoundId)
        // 注册callback
        AudioServicesAddSystemSoundCompletion(systemSoundId, nil, nil, SoundfinishedPlaying, nil)
        // 播放系统声音
        AudioServicesPlayAlertSound(systemSoundId)
    }
    
    /// 获取一段音频的详细信息
    func audioInfo() {
        let audioPath = Bundle.main.path(forResource: "三人组", ofType: "mp3")
        let audioUrl = URL.init(fileURLWithPath: audioPath!)
        // 创建打开
        var audioFile = AudioFileID.init(bitPattern: 0)
        AudioFileOpenURL(audioUrl as CFURL, .readPermission, 0, &audioFile)
        // 读取
        var dictionarySize: UInt32 = 0
        AudioFileGetPropertyInfo(audioFile!, kAudioFilePropertyInfoDictionary, &dictionarySize, UnsafeMutablePointer.init(bitPattern: 0))
        var dictoanry: CFDictionary?
        AudioFileGetProperty(audioFile!, kAudioFilePropertyInfoDictionary, &dictionarySize, &dictoanry)
        let audioDict = dictoanry as? [String : Any]
        for (key, value) in audioDict! {
            print("\(key)=\(value)")
        }
        
        AudioFileClose(audioFile!)
    }

}

