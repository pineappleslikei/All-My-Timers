//
//  TimerTableViewController.swift
//  All My Timers
//
//  Created by Christopher Ellis on 12/16/21.
//

import UIKit

class TimerTableViewController: UITableViewController {

    let dummyData = [
        "Watch Ted Lasso",
        "Go to the coffee shop",
        "Work on my coding assignment"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TimerCell", bundle: Bundle.main), forCellReuseIdentifier: "timerCell")
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dummyData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for: indexPath) as! TimerTableViewCell
        cell.label.text = dummyData[indexPath.row]
        
        return cell
    }
}
