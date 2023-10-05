//
//  TableViewController.swift
//  tableView
//
//  Created by Wonji Ha on 2023/10/05.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    
    let filePath = "/Users/wj/Documents/연습/tableView/tableView/data.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 9
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Ask for a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
       // Configure the cell’s contents with the row and section number.
       // The Basic cell style guarantees a label view is present in textLabel.
        cell.textLabel?.text = "\(indexPath.section), \(indexPath.row)"
       
       return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                    section: Int) -> String {
            
//            if section == 0
//            {
//                return "섹션 0번"
//            }
           return " "
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // 셀 선택후 바로 선택해제 하기
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellInfo = "날 만졌어\nSection \(indexPath.section), Row \(indexPath.row)"
        let alert = UIAlertController(title: "어머나", message: cellInfo, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)

        if let contents = try? String(contentsOfFile: filePath) {
            print(contents)
        }
    }
}

