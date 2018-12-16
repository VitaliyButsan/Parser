//
//  MainVC.swift
//  Parser
//
//  Created by VitKet on 8/6/18.
//  Copyright © 2018 VitKet. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mainJSONData: Any = 0
    let identifire = "Cell"
    var counter = 0
    var mainData: Any = 0
    var link: String = ""
    
    // links for parsing
    let linksArray = [
        "https://jsonplaceholder.typicode.com/users",
        "https://api.letsbuildthatapp.com/jsondecodable/courses",
        "https://gateway.marvel.com/docs/public",
        "https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json",
        "https://api.fixer.io",
        "https://api.icndb.com/jokes"
    ]
    
    // Outlets
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var blinkerInsideGetButton: UILabel!
    @IBOutlet weak var outletButtonGet: UIButton!
    
    // GET func for get requests
    @IBAction func get(_ sender: UIButton) {
        if link == "" {return}
        
        // deactivation of the 'Get' button from repeated pressing
        outletButtonGet.isEnabled = false
        // blink blinker inside button Get
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: { () -> Void in
            self.blinkerInsideGetButton.alpha = 1.0
        }, completion: nil)
        
        // create URL session
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            self.mainData = data
            DispatchQueue.main.async {
                self.blinkerInsideGetButton.backgroundColor = UIColor.green
            }
            
            do {
                self.mainJSONData = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ResponseVC", sender: self)
                }
            } catch {
                print("Err")
            }
            }.resume()
    }

    override func viewWillAppear(_ animated: Bool) {
        // activation of the 'Get' button
        outletButtonGet.isEnabled = true
        blinkerInsideGetButton.backgroundColor = UIColor.red
        blinkerInsideGetButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // rotate button1
        UIView.animate(withDuration: 0.5, delay: 1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.button1.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/32)
        }, completion: nil)
        // rotate button3
        UIView.animate(withDuration: 0.5, delay: 1, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.button3.transform = CGAffineTransform(rotationAngle: CGFloat.pi/32)
        }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
    }
    
    // create table controller
    func createTable() {
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linksArray.count
    }
    
    // create the cell and input data into it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.textLabel?.text = linksArray[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // after push on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        link = linksArray[indexPath.row]
    }
    
    // segue for transmission data next Controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ResponseVC = segue.destination as? ResponseVC {
            ResponseVC.JSONFromMainVC = mainJSONData
            ResponseVC.dataFromMainVC = mainData
        }
    }
    
}
