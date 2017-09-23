//
//  MotivationsViewController.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Public
    
    /// Reference to the Presenter's output interface.
    var output: MotivationsViewOutput!
    
    var dataDisplayManager: MotivationsDataDisplayManager!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        output.viewDidLayoutSubviews()
    }
 
}

// MARK: - MotivationsViewInput

extension MotivationsViewController: MotivationsViewInput {
    
    func configureWith(_ elements: [Motivation]) {
        dataDisplayManager.configureWith(view, collectionView: collectionView, motivations: elements)
    }
    
    func scrollToPenultimateItem() {
        dataDisplayManager.scrollToPenultimateItem()
    }
    
}

// MARK: - MotivationsDataDisplayManagerOutput

extension MotivationsViewController: MotivationsDataDisplayManagerOutput {
    
    func didTapOnMotivation(title: String, motivation: String) {
        output.didTapOnMotivation(title: title, motivation: motivation)
    }
    
}
