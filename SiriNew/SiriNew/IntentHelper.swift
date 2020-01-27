//
//  IntentHelper.swift
//  SiriNew
//
//  Created by EricM on 1/9/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import Foundation
import Intents

class IntentHandler: INExtension {
   override func handler(for intent: INIntent) -> Any? {
         return LightIntentHandler()
   }
}
