//
//  ViewController.swift
//  Parser
//
//  Created by vit on 8/6/18.
//  Copyright © 2018 vit. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var json: Any = 0
    var mainResponseData: Any = 0
    var cellText: String = ""
    let identifire = "MyCell"
    let linksArray = [
        "http://jsonplaceholder.typicode.com/users",
        "https://api.letsbuildthatapp.com/jsondecodable/courses",
"https://gateway.marvel.com/docs/public",
        "https://mdn.github.io/learning-area/javascript/oojs/json/superheroes.json"
    ]
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var smallLabelInsideGetButton: UILabel!
    @IBOutlet weak var my_Get: UIButton!
    // GET func for get requests
    @IBAction func get(_ sender: UIButton){
        if cellText == "" {return}
        my_Get.isEnabled = false
//        DispatchQueue.main.sync{
//            self.smallLabelInsideGetButton.backgroundColor = UIColor.red
//        }
        print(cellText)
        // blinking button1
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: { () -> Void in
            self.smallLabelInsideGetButton.alpha = 1.0
        }, completion: nil)

        guard let url = URL(string: cellText) else { return }
         URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            self.mainResponseData = data
            DispatchQueue.main.sync {
                self.smallLabelInsideGetButton.backgroundColor = UIColor.green
            }
                do {
                self.json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "ResponseVC", sender: self)
                }
            } catch {
                print("Err")
            }
          
        }.resume()
    }


    // segue for transmission data betwen Controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ResponseViewController = segue.destination as? ResponseViewController {
            ResponseViewController.jsON = json
            ResponseViewController.responseData = mainResponseData
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        self.smallLabelInsideGetButton.backgroundColor = UIColor.red
        self.smallLabelInsideGetButton.alpha = 0.05

    }
    // view did appear
    override func viewDidAppear(_ animated: Bool) {

         my_Get.isEnabled = true
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
    
    // table view
    func createTable() {
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        //myTableView.backgroundColor = UIColor.red
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //MARK: - UITableViewDetaSource

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
       cellText = linksArray[indexPath.row]
        print(cellText)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return linksArray.count
    }
    // insert data into a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)

        let row = indexPath.row
        cell.textLabel?.text = linksArray[row]
        cell.backgroundColor = UIColor.clear

        return cell

    }

    
    
}

