//
//  ParsingTVC.swift
//  Parser
//
//  Created by VitKet on 9/11/18.
//  Copyright © 2018 VitKet. All rights reserved.
//

import UIKit

class ParsingTVC: UITableViewController {
    let identifireCell = "ParsingDataCell"
    var parsingKeysArray: [String] = []
    var parsingValuesArray: [Any] = []

    override func viewWillAppear(_ animated: Bool){
        print(parsingValuesArray)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parsingKeysArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifireCell, for: indexPath)

        let row = indexPath.row
        cell.textLabel?.text = parsingKeysArray[row] + ": " + "\(parsingValuesArray[row])"
        cell.backgroundColor = UIColor.clear
        return cell
    }

}
