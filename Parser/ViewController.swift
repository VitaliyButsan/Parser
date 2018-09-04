//
//  ViewController.swift
//  Parser
//
//  Created by vit on 8/6/18.
//  Copyright © 2018 vit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var json: Any = 0
    var jsonCreated = false
    let identifire = "MyCell"

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    // GET func for get requests
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
    
    // segue for transmission data betwen Controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        while self.jsonCreated != true {
            print(".", terminator: "")
        }
        if let ViewController2 = segue.destination as? ViewController2 {
            ViewController2.jsON = json
        }
    }
    
    // view did appear
    override func viewDidAppear(_ animated: Bool) {
        // rotate button1
        UIView.animate(withDuration: 0.5, delay: 1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.button1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/32)
        }, completion: nil)
        // rotate button3
        UIView.animate(withDuration: 0.5, delay: 1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.button3.transform = CGAffineTransform(rotationAngle: CGFloat.pi/32)
        }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
    }
    
    // table view
    func createTable() {
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        //myTableView.backgroundColor = UIColor.red
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    //MARK: - UITableViewDetaSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        case 2:
            return 7
        default:
            break
        }
        return 0
    }
    // insert data into a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.textLabel?.text = "row=\(indexPath.section), cell=\(indexPath.row)"
        cell.backgroundColor = UIColor.clear
        return cell
    }

    
    
}

