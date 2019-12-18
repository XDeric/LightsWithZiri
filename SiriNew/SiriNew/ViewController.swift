//
//  ViewController.swift
//  SiriNew
//
//  Created by EricM on 12/12/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import UIKit
import Intents
import IntentsUI

class ViewController: UIViewController {

    //MARK: variables
    
    lazy var message: UILabel = {
        let label = UILabel()
        label.text = "OFF"
        label.font?.withSize(25)
        label.textAlignment = .center
        return label
    }()
    
    lazy var lightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lights", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(changeStatus), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: Functions
    @objc func changeStatus(){
        if message.text == "ON" {
            message.text = "OFF"
        } else {
            message.text = "ON"
        }
    }
    
//    private func sendStatusUp(message: String){
//        FirestoreService.manager.createPost(button: <#T##ButtonStatus#>) { (result) in
//            <#code#>
//        }
//    }

    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setupIntents()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    //MARK: setting intent for siri
    private func setupIntents(){
        let actionIdentifier = "practice.SiriNew"
        let activity = NSUserActivity(activityType: actionIdentifier)
        activity.title = "Change Lights Status"
        activity.userInfo = ["speech" : "change lights"]
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier("practice.SiriNew")
        activity.suggestedInvocationPhrase = "Light"
        self.userActivity = activity
        self.userActivity?.becomeCurrent()
    }
    
    private func setupConstraints(){
        message.translatesAutoresizingMaskIntoConstraints = false
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(message)
        view.addSubview(lightButton)
        
        NSLayoutConstraint.activate([
            message.heightAnchor.constraint(equalToConstant: 50),
            message.widthAnchor.constraint(equalToConstant: 150),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            lightButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 10),
            lightButton.leadingAnchor.constraint(equalTo: message.leadingAnchor),
            lightButton.heightAnchor.constraint(equalToConstant: 50),
            lightButton.widthAnchor.constraint(equalTo: message.widthAnchor)
        
        ])
        
    }


}

