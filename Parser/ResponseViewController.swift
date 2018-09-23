//
//  ViewController2.swift
//  Parser
//
//  Created by vit on 8/8/18.
//  Copyright © 2018 vit. All rights reserved.
//

import UIKit

struct ParseValue: Decodable {
    var arr = ["name", "link", "id"]
}

class ResponseViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!

    var jsON: Any = 0
    var responseData: Any = 0
    var responseInputKeysArray: [String] = []
    var responseValuesWithoutKeysArray : [Any] = []
    var counter = 0

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
        self.textView.text = "\(jsON.self)"
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

    // handle if keyboard is show
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }

    // handle if keyboard is hide
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }

    @IBAction func fixButton(_ sender: UIButton) {
        let inputKey = textField.text!
        textField.text = ""

        do {
            if let dictionaryData = try JSONSerialization.jsonObject(with: responseData as! Data) as? [String: Any] {
                for (key, value) in dictionaryData {
                    if key == inputKey {
                        responseInputKeysArray.append(inputKey)
                        responseValuesWithoutKeysArray.append(value)
                        print("MEMBER: \(key) OMG \(value)")
                    }
//                    print(key + ":", value)
                }
            } else {
                if let arrayData = try JSONSerialization.jsonObject(with: responseData as! Data) as? [[String: Any]] {
                    for value in arrayData {

                        for (ky,vale) in value {
                            if ky == inputKey {
                                responseInputKeysArray.append(inputKey)
                                responseValuesWithoutKeysArray.append(vale)
                                print("MOONLIGHT: \(ky) OMG \(vale)")
                            }
                        }
                    }
                }
            }
        } catch {}


        //        do {
        //            let jsn = try JSONDecoder().decode([ParseValue].self, from: responseData as! Data)
        //            print("My", jsn)
        //        } catch let error {
        //            print(error)
        //        }
    }
    @IBAction func parserButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "Parser", sender: self)
        }

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ParsingDataTableViewController = segue.destination as? ParsingDataTableViewController {
            ParsingDataTableViewController.parsingDataInputKeysArray = responseInputKeysArray
            ParsingDataTableViewController.parsingDataValuesWithOutKeysArray = responseValuesWithoutKeysArray
        }
    }

}
