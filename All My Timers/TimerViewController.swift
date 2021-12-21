//
//  ViewController.swift
//  All My Timers
//
//  Created by Christopher Ellis on 12/15/21.
//

import UIKit

class TimerViewController: UIViewController {
    
    let tableView = TimerTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
        
        
        if let sheet = tableView.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 25
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        tableView.isModalInPresentation = true
        present(tableView, animated: true, completion: nil)
    }

}

