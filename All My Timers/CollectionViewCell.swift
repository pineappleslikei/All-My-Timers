//
//  CollectionViewCell.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/21/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell, TaskTimerDelegate {
    
    var name: String? {
        didSet {
            titleLabel.text = name
        }
    }
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    var taskTimer = TaskTimer()
    var model: Task?
    weak var delegate: TaskCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // MARK: Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()

        taskTimer.delegate = self
        
        button.tintColor = ColorScheme.playButton
        contentView.layer.cornerRadius = 15.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradientLayer()
        configureShadow()
    }
    
    private func configureGradientLayer(){
        backgroundColor = .clear
        let gradient = CAGradientLayer()
        gradient.colors = [ColorScheme.cellBackground1.cgColor, ColorScheme.cellBackground2.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = bounds
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func configureShadow() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 0.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
    
    func configModel(taskModel: Task) {
        model = taskModel
        
        name = model?.name
        descriptionText = model?.description
    }
    
    // MARK: IB Actions
    
    @IBAction func startTimer(_ sender: Any) {
        if !taskTimer.isRunning {
            taskTimer.start()
        } else {
            taskTimer.stop()
        }
    }
    
    // MARK: Delegate Methods
    
    func displayValueChanged(newDisplayValue: String) {
        timeLabel.text = newDisplayValue
    }
    
    func didStartRunning() {
        button.setTitle("Stop", for: .normal)
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = ColorScheme.pauseButton
    }
    
    func didStopRunning(taskEntry: TaskEntry) {
        model?.taskEntries.append(taskEntry)
        self.delegate?.saveModel(for: self, model: model ?? Task(name: "Unknown", description: ""))
        
        button.setTitle("Start", for: .normal)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = ColorScheme.playButton
    }
}

protocol TaskCellDelegate: AnyObject {
    func saveModel(for cell: CollectionViewCell, model: Task)
}
