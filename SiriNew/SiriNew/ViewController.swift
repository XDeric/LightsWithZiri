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
    
    lazy var addButtons: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.square.fill"), for: .normal)
        button.addTarget(self, action: #selector(addSwitch), for: .touchUpInside)
        return button
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
    
    lazy var buttonTableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        tv.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        return tv
    }()
    
    lazy var addShortcut: UIButton = {
        let button = UIButton()
        button.setTitle("Add Light Shortcut", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addNewLightShortcutWasTapped), for: .touchUpInside)
        
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
    
    @objc func addNewLightShortcutWasTapped() {
      // Open View Controller to Create New Shortcut
        let newLightActivity = Light.newLightShortcut(with: UIImage(named: "lightbulb"))
      let shortcut = INShortcut(userActivity: newLightActivity)
      
      let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
      vc.delegate = self
      
      present(vc, animated: true, completion: nil)
    }
    
    @objc private func addSwitch() {

    }
    
    func showAlert(text: String){
        let alert = UIAlertController(title: "Enter name", message: "Name the Lights the switch is controlling", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input switch control name here..."
        })
        self.present(alert, animated: true)
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
        //setupIntents()
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupConstraints(){
        message.translatesAutoresizingMaskIntoConstraints = false
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        buttonTableView.translatesAutoresizingMaskIntoConstraints = false
        addButtons.translatesAutoresizingMaskIntoConstraints = false
        addShortcut.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(buttonTableView)
        view.addSubview(message)
        view.addSubview(lightButton)
        view.addSubview(addShortcut)
        //view.addSubview(addButtons)
        
        NSLayoutConstraint.activate([
//            addButtons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            addButtons.leadingAnchor.constraint(equalTo: view.leftAnchor, constant: 200),
//            addButtons.trailingAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//            addButtons.heightAnchor.constraint(equalToConstant: 50),
//
//            buttonTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            buttonTableView.leadingAnchor.constraint(equalTo: view.leftAnchor),
//            buttonTableView.trailingAnchor.constraint(equalTo: view.rightAnchor),
//            buttonTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            message.heightAnchor.constraint(equalToConstant: 50),
            message.widthAnchor.constraint(equalToConstant: 150),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            addShortcut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addShortcut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addShortcut.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addShortcut.bottomAnchor.constraint(equalTo: message.topAnchor, constant: -250),
            
            lightButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 10),
            lightButton.leadingAnchor.constraint(equalTo: message.leadingAnchor),
            lightButton.heightAnchor.constraint(equalToConstant: 50),
            lightButton.widthAnchor.constraint(equalTo: message.widthAnchor)
        
        ])
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ButtonList.switches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = buttonTableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
  func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                      didFinishWith voiceShortcut: INVoiceShortcut?,
                                      error: Error?) {
    dismiss(animated: true, completion: nil)
  }
  
  func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
    dismiss(animated: true, completion: nil)
  }
}
