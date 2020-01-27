//
//  ButtonTableViewCell.swift
//  SiriNew
//
//  Created by EricM on 1/7/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    
    
    lazy var onOrOFF: UISwitch = {
        let light = UISwitch()
        
        return light
    }()
    
    lazy var labelName: UILabel = {
        let text = UILabel()
        text.text = ""
        return text
    }()

    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}
