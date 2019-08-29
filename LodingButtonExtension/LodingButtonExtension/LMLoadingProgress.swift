//
//  LMLoadingProgress.swift
//  LodingButtonExtension
//
//  Created by 叶世昌 on 2018/12/18.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

class LMLoadingProgress: CALayer {

    var number: Float = 0.0 {
        didSet {
            textLayer.string = String.init(format: "%.0f%%", number * 100)
            textLayer.setNeedsDisplay()
            setNeedsDisplay()
        }
    }
    let textLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.foregroundColor = UIColor.black.cgColor
        let font = UIFont.systemFont(ofSize: 10)
        textLayer.font = font.fontName as CFTypeRef
        textLayer.fontSize = font.pointSize
        textLayer.alignmentMode = .center
        textLayer.isWrapped = true
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }()
    
    override init() {
        super.init()
        backgroundColor = UIColor.red.cgColor
        addSublayer(textLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        super.layoutSublayers()
        let tH = NSString.init(string: "100%").boundingRect(with: CGSize.init(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10)], context: nil).height
        textLayer.frame = CGRect.init(x: 0, y: frame.height*0.5 - tH * 0.5, width: frame.width, height: tH)
    }
    
    override func draw(in ctx: CGContext) {
        
        let radius: CGFloat = 20
        let center = CGPoint.init(x: frame.size.width/2, y: frame.size.height/2)
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(2)
        ctx.setLineCap(.round)
        
        let endAngle = CGFloat(number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: CGFloat.pi*3/2, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
    }
}
