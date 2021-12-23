//
//  CollectionViewController.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/21/21.
//

import UIKit



class CollectionViewController: UICollectionViewController {

    var timers = [Task]()
    
    private let reuseIdentifier = "Cell"
    let columnLayout = ColumnFlowLayout (cellsPerRow: 2, minimumInteritemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    // MARK: UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Timers"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        collectionView.backgroundColor = ColorScheme.viewBackground
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
    }
    
    @objc private func didTapAdd() {
        let ac = UIAlertController(title: "Add a task", message: nil, preferredStyle: .alert)
        ac.addTextField { textField in
            textField.placeholder = "Task Name"
        }
        ac.addTextField { textField in
            textField.placeholder = "Task Description"
        }
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let textFields = ac.textFields else { return }
            guard let name = textFields[0].text else { return }
            if let description = textFields[1].text {
                self.insertCellAtTop(name: name, description: description)
            } else {
                self.insertCellAtTop(name: name, description: "")
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    private func insertCellAtTop(name: String, description: String) {
        timers.insert(Task(name: name, description: description), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return timers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let timer = timers[indexPath.row]
        cell.name = timer.name
        cell.descriptionText = timer.description
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
