//
//  MotivationsViewController.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 7/1/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationsViewController: UIViewController, MotivationsViewInput {
    
    // MARK: - Constants
    
    fileprivate struct C {
        struct CellReuseIdentifiers {
            static let Motivation = "MotivationCell"
        }
        struct Animation {
            static let duration = 0.8
            struct Transform {
                static let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                static let identity = CGAffineTransform.identity
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Variables
    
    /// Motivations array
    fileprivate var motivations: [Motivation] = []
    
    fileprivate var isFirstTimeTransform = true
    
    
    // MARK: - Public
    
    /// Reference to the Presenter's output interface.
    var output: MotivationsViewOutput!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewSetup()
        
        output.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        output.viewDidLayoutSubviews()
    }
    
    
    // MARK: - MotivationsViewInput
    
    func updateMotivations(_ elements: [Motivation]) {
        isFirstTimeTransform = true
        
        motivations.removeAll()
        motivations.append(contentsOf: elements)
        
        collectionView.reloadData()
    }
    
    func scrollToPenultimateItem() {
        let indexPath = NSIndexPath(item: motivations.count - 2, section: 0) as IndexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    
    // MARK: - View Setup
    
    private func collectionViewSetup() {
        let nib = UINib(nibName: MotivationCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: C.CellReuseIdentifiers.Motivation)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(UIScreen.main.bounds.size.width - 100)
        
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        } else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        
        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if (newTargetOffset > Float(scrollView.contentSize.width)) {
            newTargetOffset = Float(Float(scrollView.contentSize.width))
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
        
        var index = Int(newTargetOffset / pageWidth)
        
        if index == 0 {
            var cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0))
            UIView.animate(withDuration: C.Animation.duration, animations: {
                cell?.transform = C.Animation.Transform.identity
                cell?.alpha = 1
            })
            
            cell = collectionView.cellForItem(at: IndexPath(item: index+1, section: 0))
            UIView.animate(withDuration: C.Animation.duration, animations: {
                cell?.transform = C.Animation.Transform.scale
                cell?.alpha = 0.5
            })
            
        } else {
            
            var cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0))
            UIView.animate(withDuration: C.Animation.duration, animations: {
                cell?.transform = C.Animation.Transform.identity
                cell?.alpha = 1
            })
            
            index -= 1
            cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0))
            UIView.animate(withDuration: C.Animation.duration, animations: {
                cell?.transform = C.Animation.Transform.scale
                cell?.alpha = 0.5
            })
            
            index += 1
            index += 1
            cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0))
            UIView.animate(withDuration: C.Animation.duration, animations: {
                cell?.transform = C.Animation.Transform.scale
                cell?.alpha = 0.5
            })
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MotivationsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motivations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = C.CellReuseIdentifiers.Motivation
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! MotivationCollectionViewCell
        
        let motivation = motivations[indexPath.row]
        cell.configureWith(motivation)
        
        // make a bool and set YES initially, this check will prevent fist load transform
        if (indexPath.row == motivations.count - 2 && isFirstTimeTransform) {
            isFirstTimeTransform = false
            cell.alpha = 1
            cell.transform = C.Animation.Transform.identity
        } else {
            // the new cell will always be transform and without animation
            cell.transform = C.Animation.Transform.scale
            cell.alpha = 0.5
        }
        
        return cell
    }
    
}


// MARK: - UICollectionViewDataSource

extension MotivationsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension MotivationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 100
        let height = UIScreen.main.bounds.height - 200
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let frameWidth = UIScreen.main.bounds.size.width
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width - 100
        
        let result = (frameWidth - cellWidth) / 2
        
        return UIEdgeInsets(top: 0, left: result, bottom: 0, right: result)
    }
    
}
