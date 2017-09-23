//
//  MotivationsDataDisplayManager.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit
import Foundation

protocol MotivationsDataDisplayManager: class {
    
    func configureWith(_ view: UIView, collectionView: UICollectionView, motivations: [Motivation])
    
    func scrollToPenultimateItem()
}

