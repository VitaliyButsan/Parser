//
//  ViewController2.swift
//  Parser
//
//  Created by vit on 8/8/18.
//  Copyright © 2018 vit. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    //@IBOutlet weak var textField: UITextField!
    var jsON: Any = 777
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Listen for keyboard events
        registerKeyboardNotification()
        // appear data on view
        print("FirstSTEP")
        textView.isEditable = false
        self.textView.text = "\(jsON.self)"
    }

    deinit {
        // Stop listening for keyboard hide/show events when View closed
        removeKeyboardNotifications()
    }
    
    // create kb notifications for kbWillShow and kbWillHide
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // remove notifications after all
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // handle if kb is show
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    // handle if kb is hide
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }

}
