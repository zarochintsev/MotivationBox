//
// MotivationsViewController.swift
//
// MIT License
//
// Copyright (c) 2017 Alex Zarochintsev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

class MotivationsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - General
    
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
