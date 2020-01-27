//
//  LightActivity.swift
//  SiriNew
//
//  Created by EricM on 1/14/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import Foundation
import Intents
import MobileCoreServices
import CoreSpotlight
import UIKit


//MARK: setting intent for siri
private func setupIntents(){
    let actionIdentifier = "com.pursuit.lightsoff"
    let activity = NSUserActivity(activityType: actionIdentifier)
    activity.title = "Change Lights Status"
    activity.userInfo = ["speech" : "change lights"]
    activity.isEligibleForSearch = true
    activity.isEligibleForPrediction = true
    activity.persistentIdentifier = NSUserActivityPersistentIdentifier("com.pursuit.lightsoff")
    activity.suggestedInvocationPhrase = "Light" // siri activation phrase
    let vc = ViewController()
    vc.userActivity = activity
    activity.becomeCurrent()
}



public let kNewArticleActivityType = "com.pursuit.lightsoff"

public class Light{
  
  public static func newLightShortcut(with thumbnail: UIImage?) -> NSUserActivity {
    let activity = NSUserActivity(activityType: kNewArticleActivityType)
    activity.persistentIdentifier = NSUserActivityPersistentIdentifier(kNewArticleActivityType)
    
    activity.isEligibleForSearch = true
    activity.isEligibleForPrediction = true
    
    let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
    
    // Title
    activity.title = "Change Lights Status"
    
    // Subtitle
    attributes.contentDescription = "Turn On/Off"
    
    // Thumbnail
    attributes.thumbnailData = thumbnail?.jpegData(compressionQuality: 1.0)
    
    // Suggested Phrase
    activity.suggestedInvocationPhrase = "Light"
    
    activity.contentAttributeSet = attributes
    return activity
  }
}
