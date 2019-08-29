//
//  TableViewCell.swift
//  LodingButtonExtension
//
//  Created by 叶世昌 on 2018/12/6.
//  Copyright © 2018 Luomi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var label2: UILabel!
    var label1: UILabel!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        label1 = UILabel.init()
        label2 = UILabel.init()
        label2.text = "小豆芽"
        label1.text = "小豆芽"
        label1.sizeToFit()
        label2.sizeToFit()
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        
        label1.frame = CGRect.init(x: 100, y: 0, width: 200, height: 40)
        label2.frame = CGRect.init(x: 250, y: 0, width: 150, height: 40)
        label1.center.y = contentView.center.y
        label2.center.y = contentView.center.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
