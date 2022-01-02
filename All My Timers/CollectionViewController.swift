//
//  CollectionViewController.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/21/21.
//

import UIKit



class CollectionViewController: UICollectionViewController, TaskCellDelegate {

    var tasks = [Task]()
    
    private let reuseIdentifier = "Cell"
    let columnLayout = ColumnFlowLayout (cellsPerRow: 2, minimumInteritemSpacing: 10, minimumLineSpacing: 10, sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    
    // MARK: UIView Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSavedUserData()
        
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = editButtonItem
        
        collectionView.backgroundColor = ColorScheme.viewBackground
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = columnLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }
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
            if name == ""  {
                print("No Task name was provided")
                return
            }
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
        tasks.insert(Task(name: name, description: description), at: 0)
        saveUserData()
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.insertItems(at: [indexPath])
    }
    
    private func deleteCell(from indexPath: IndexPath) {
        tasks.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        saveUserData()
    }
    
    // MARK: User Default CRUD
    
    private func saveUserData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tasks) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: CRUD.tasksKey)
        }
    }
    
    private func loadSavedUserData() {
        if let savedTasks = UserDefaults.standard.object(forKey: CRUD.tasksKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedTasks = try? decoder.decode([Task].self, from: savedTasks) {
                tasks = loadedTasks
            }
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tasks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let task = tasks[indexPath.row]
        cell.configModel(taskModel: task)
        cell.isEditing = isEditing
        cell.deleteButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: TaskCellDelegate
    
    func saveModel(for cell: CollectionViewCell, model: Task) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        tasks[indexPath.row] = model
        
        saveUserData()
    }
    
    // MARK: Actions
    
    @objc func didTapMinusButton(sender: UIButton) {
        let indexPath = collectionView.indexPath(for: sender.superview?.superview as! CollectionViewCell)
        if let indexPath = indexPath {
            deleteCell(from: indexPath)
        }
        
    }

}
