//
//  ViewController.swift
//  Parser
//
//  Created by vit on 8/6/18.
//  Copyright © 2018 vit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var json: Any = 666
    var jsonCreated = false

    @IBAction func get(_ sender: UIButton){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                self.json = try JSONSerialization.jsonObject(with: data, options: [])
                self.jsonCreated = true
                print("\nJSON_Created")
            } catch {
                print("Err")
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        while self.jsonCreated != true {
            print(".", terminator: "")
        }
        if let ViewController2 = segue.destination as? ViewController2 {
            ViewController2.jsON = json
            print("NULL-STEP")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
}

