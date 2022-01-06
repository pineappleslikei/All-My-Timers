//
//  DetailViewController.swift
//  All My Timers
//
//  Created by Chris Ellis on 1/1/22.
//

import UIKit

class DetailViewController: UITableViewController {

    var task: Task?
    let fields = [
        "Name",
        "Description",
        "Color"
    ]
    var data: [String]?
    
    private let detailIdentifier = "detailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Edit Task"
        isModalInPresentation = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: detailIdentifier)
        
        if let task = task {
            data = [
                task.name,
                task.description,
                task.color
            ]
        }
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailIdentifier, for: indexPath) as! DetailTableViewCell
        
        let field = fields[indexPath.row]
        cell.label.text = field
        
        if let taskData = data?[indexPath.row] {
            cell.textField.text = taskData
        } else {
            cell.textField.text = ""
        }
        
        return cell
    }

    
    // MARK: Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapSave() {
        let name = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DetailTableViewCell
        let description = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DetailTableViewCell
        let color = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! DetailTableViewCell
        
        if let task = task {
            task.name = name.textField.text ?? ""
            task.description = description.textField.text ?? ""
            task.color = color.textField.text ?? ""
        }
        
        dismiss(animated: true)
    }

}
