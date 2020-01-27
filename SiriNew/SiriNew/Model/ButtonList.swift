//
//  ButtonList.swift
//  SiriNew
//
//  Created by EricM on 1/8/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import Foundation

class ButtonList {
    
    var name: String
    
    init(name: String){
        self.name = name
    }
    
    static var switches: [ButtonList] = [ButtonList(name: "light")]
}
