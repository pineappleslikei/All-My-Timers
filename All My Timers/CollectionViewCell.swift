//
//  CollectionViewCell.swift
//  All My Timers
//
//  Created by Chris Ellis on 12/21/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.tintColor = ColorScheme.playButton
        contentView.layer.cornerRadius = 15.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureGradientLayer()
        configureShadow()
    }
    
    func configureGradientLayer(){
        backgroundColor = .clear
        let gradient = CAGradientLayer()
        gradient.colors = [ColorScheme.cellBackground1.cgColor, ColorScheme.cellBackground2.cgColor]
        gradient.locations = [0, 1]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height)
        gradient.frame = bounds
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    func configureShadow() {
        layer.cornerRadius = 15.0
        layer.borderWidth = 0.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
    
}
