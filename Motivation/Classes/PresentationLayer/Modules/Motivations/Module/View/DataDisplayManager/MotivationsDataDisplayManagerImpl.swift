//
//  MotivationsDataDisplayManagerImpl.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class MotivationsDataDisplayManagerImpl: NSObject {
    
    weak var output: MotivationsDataDisplayManagerOutput!
    
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
        struct Collection {
            static let cellHeight: Float = 320.0
            static let lineSpacing: Float = 15.0
            static let sideEdgeInset: Float = 30.0
            static let scaleFactor: Float = 0.11
        }
    }
    
    weak var view: UIView!
    weak var collectionView: UICollectionView!
    var motivations: [Motivation] = []
    
    
    
    func scrollView(scrollView: UIScrollView, transformCell cell: MotivationCollectionViewCell) {
        let width = Float(scrollView.frame.width)
        let cellWidth = Float(width - C.Collection.sideEdgeInset * 2)
        
        let superviewCenter = scrollView.center
        let cellCenter = scrollView.convert(cell.center, to: view)
        let offset = Float(fabs(superviewCenter.x - cellCenter.x))
        
        let transformDirection = Float(cellCenter.x > superviewCenter.x ? -1.0 : 1.0)
        
        let scale = 1.0 - (C.Collection.scaleFactor * (offset / cellWidth))
        let translate = ((cellWidth - cellWidth * scale) / 2) * transformDirection
        
        var transform = CGAffineTransform.identity
        transform = transform.scaledBy(x: CGFloat(scale), y: CGFloat(scale))
        transform = transform.translatedBy(x: CGFloat(translate), y: CGFloat(0.0))
        
        cell.layerView.transform = transform
    }
}

// MARK: - MotivationsDataDisplayManager

extension MotivationsDataDisplayManagerImpl: MotivationsDataDisplayManager {
    
    func configureWith(_ view: UIView, collectionView: UICollectionView, motivations: [Motivation]) {
        self.view = view
        self.collectionView = collectionView
        self.motivations = motivations
        
        let nib = UINib(nibName: MotivationCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: C.CellReuseIdentifiers.Motivation)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func scrollToPenultimateItem() {
        let indexPath = NSIndexPath(item: motivations.count - 2, section: 0) as IndexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
}

// MARK: - UICollectionViewDataSource

extension MotivationsDataDisplayManagerImpl: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return motivations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = C.CellReuseIdentifiers.Motivation
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! MotivationCollectionViewCell
        
        let motivation = motivations[indexPath.row]
        cell.configureWith(motivation)
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension MotivationsDataDisplayManagerImpl: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        // If selected last cell, return
        if (indexPath.row == self.motivations.count - 1) {
            return
        }
        
        let motivation = motivations[indexPath.row]
        output.didTapOnMotivation(title: motivation.title, motivation: motivation.message)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MotivationsDataDisplayManagerImpl: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Float(collectionView.frame.width)
        let cellWidth = Float(width - C.Collection.sideEdgeInset * 2)
        
        return CGSize(width: CGFloat(cellWidth), height: CGFloat(C.Collection.cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(C.Collection.lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let topEdgeInset = CGFloat((Float(collectionView.frame.height) - C.Collection.cellHeight) / 2)
        return UIEdgeInsets(top: topEdgeInset, left: CGFloat(C.Collection.sideEdgeInset), bottom: topEdgeInset, right: CGFloat(C.Collection.sideEdgeInset))
    }
    
}

// MARK: - UIScrollViewDelegate

extension MotivationsDataDisplayManagerImpl: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let width = Float(scrollView.frame.width)
        let cellWidth = Float(width - C.Collection.sideEdgeInset * 2)
        
        let pageWidth = Float(cellWidth + C.Collection.lineSpacing)
        
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0.0
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        } else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        
        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if newTargetOffset > Float(scrollView.contentSize.width) {
            newTargetOffset = Float(scrollView.contentSize.width)
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells as! [MotivationCollectionViewCell] {
            self.scrollView(scrollView: scrollView, transformCell: cell)
        }
    }
    
}
