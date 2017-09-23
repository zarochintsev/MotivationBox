//
//  MotivationCollectionViewCell.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var layerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layerView.layer.cornerRadius = 10
        layerView.layer.masksToBounds = true
        layerView.backgroundColor =  UIColor(
            red: 224 / 255.0,
            green: 224 / 255.0,
            blue: 224 / 255.0,
            alpha: 1)
    }
    
    // MARK: - Public
    
    func configureWith(_ motivation: Motivation) {
        titleLabel.text = motivation.title
        messageLabel.text = motivation.message
    }
    
}
