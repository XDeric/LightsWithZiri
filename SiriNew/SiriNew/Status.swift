//
//  Status.swift
//  SiriNew
//
//  Created by EricM on 12/13/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct ButtonStatus {
    let on: Bool
    let buttonID: String
    
    init(on: Bool){
        self.on = on
        self.buttonID = UUID().description
    }
    
    init?(from dict: [String: Any], buttonID: String) {
        guard let on = dict["on"] as? Bool else {return nil}
        
        self.on = on
        self.buttonID = buttonID
    }
    
    var fieldsDict: [String: Any] {
        return [
            "on": self.on
        ]
    }
    
}
