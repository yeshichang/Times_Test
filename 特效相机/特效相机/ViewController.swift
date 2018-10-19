//
//  ViewController.swift
//  特效相机
//
//  Created by 叶世昌 on 2018/10/18.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        convertImageFormatTest()
        testImageGray()
        testImageReColor()
        testImageReColor2()
        testImageHighlightColor()
    }
    
    @IBAction func imageCamare(_ sender: Any) {
        configImageController()
    }
    // 相机相册
    func configImageController() {
        let controller = UIImagePickerController.init()
        controller.sourceType = .camera
        controller.delegate = self
        navigationController?.present(controller, animated: true, completion: nil)
    }
    
    func testImageHighlightColor() {
        let image = #imageLiteral(resourceName: "1111")
        let imageData = convertUIImagetoData(image: image)
        let newImageData = Tools.imageHighlight(withData: imageData, width: image.size.width, height: image.size.height)
        let newImage = convertDatatoUIimage(imageData: newImageData, imageSource: image)
        imageView6.image = newImage
    }
    
    func testImageReColor2() {
        let image = #imageLiteral(resourceName: "1111")
        let imageData = convertUIImagetoData(image: image)
        let newImageData1 = Tools.imageGray(withData: imageData, width: image.size.width, height: image.size.height)
        let newImageData2 = Tools.imageReColor(withData: newImageData1, width: image.size.width, height: image.size.height)
        let newImage = convertDatatoUIimage(imageData: newImageData2, imageSource: image)
        imageView5.image = newImage
    }
    
    func testImageReColor() {
        let image = #imageLiteral(resourceName: "1111")
        let imageData = convertUIImagetoData(image: image)
        let newImageData = Tools.imageReColor(withData: imageData, width: image.size.width, height: image.size.height)
        let newImage = convertDatatoUIimage(imageData: newImageData, imageSource: image)
        imageView4.image = newImage
    }
    
    func testImageGray() {
        let image = #imageLiteral(resourceName: "1111")
        let imageData = convertUIImagetoData(image: image)
        let newImageData = Tools.imageGray(withData: imageData, width: image.size.width, height: image.size.height)
        let newImage = convertDatatoUIimage(imageData: newImageData, imageSource: image)
        imageView3.image = newImage
    }
    
    func convertImageFormatTest() {
        let image = #imageLiteral(resourceName: "1111")
        let imageData = convertUIImagetoData(image: image)
        let imageNew = convertDatatoUIimage(imageData: imageData, imageSource: image)
        imageView2.image = imageNew
    }

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    
    func convertUIImagetoData(image: UIImage) -> UnsafeMutablePointer<UInt8> {
        
        return Tools.convertUIImage(toData: image)
    }
    
    func convertDatatoUIimage(imageData: UnsafeMutablePointer<UInt8>, imageSource: UIImage) -> UIImage {
        
        return Tools.convertData(toUIImage: imageData, image: imageSource)
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        let image = info[convertFromUIImagePickerControllerInfoKey(.originalImage)] as! UIImage
        let imageData = convertUIImagetoData(image: image)
        let imageDataNew = Tools.imageGray(withData: imageData, width: image.size.width, height: image.size.height)
        let imageNew = convertDatatoUIimage(imageData: imageDataNew, imageSource: image)
        UIImageWriteToSavedPhotosAlbum(imageNew, nil, nil, nil);
        
        dismiss(animated: true, completion: nil)
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
