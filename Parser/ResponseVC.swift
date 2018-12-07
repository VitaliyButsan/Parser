//
//  ResponseVC.swift
//  Parser
//
//  Created by VitKet on 8/8/18.
//  Copyright © 2018 VitKet. All rights reserved.
//

import UIKit

class ResponseVC: UIViewController {
    var JSONFromMainVC: Any = 0
    var dataFromMainVC: Any = 0
    var inputKeysArray: [String] = []
    var responseValuesArray : [Any] = []
    var counter = 0

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Listen for keyboard events
        registerKeyboardNotification()
        // appear data on view
        textView.isEditable = false
        self.textView.text = "\(JSONFromMainVC.self)"
    }

    deinit {
        // Stop listening for keyboard hide/show events when View closed
        removeKeyboardNotifications()
    }

    // create kb notifications for kbWillShow and kbWillHide
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name:
            UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // remove notifications after all
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // if keyboard will show
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }

    // if keyboard will hide
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    // put input keys and values to array
    @IBAction func fixButton(_ sender: UIButton) {
        let inputKey = textField.text!
        textField.text = ""
        // check to type of JSONfromMainVC
        do {
            if let dictionaryData = try JSONSerialization.jsonObject(with: dataFromMainVC as! Data) as? [String: Any] {
                for (key, value) in dictionaryData {
                    if key == inputKey {
                        inputKeysArray.append(inputKey)
                        responseValuesArray.append(value)
                        print("MEMBER: \(key) OMG \(value)")
                    }
                }
            } else {
                if let arrayData = try JSONSerialization.jsonObject(with: dataFromMainVC as! Data) as? [[String: Any]] {
                    for cell in arrayData {
                        for (key, value) in cell {
                            if key == inputKey {
                                inputKeysArray.append(inputKey)
                                responseValuesArray.append(value)
                                print("MOONLIGHT: \(key) OMG \(value)")
                            }
                        }
                    }
                }
            }
        } catch {}
    }
    
    @IBAction func parserButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Parser", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ParsingTVC = segue.destination as? ParsingTVC {
            ParsingTVC.parsingKeysArray = inputKeysArray
            ParsingTVC.parsingValuesArray = responseValuesArray
        }
        if let MainVC = segue.destination as? MainVC {
            MainVC.button1.backgroundColor = UIColor.red
        }
    }

    
}
