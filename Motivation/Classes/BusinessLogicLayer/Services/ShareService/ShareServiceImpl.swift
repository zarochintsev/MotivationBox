//
//  ShareServiceImpl.swift
//  Motivation
//
//  Created by Alex Zarochintsev on 9/13/17.
//  Copyright © 2017 [Zarochintsev Production];. All rights reserved.
//

import UIKit

class ShareServiceImpl {
    
}

// MARK: - ShareService

extension ShareServiceImpl: ShareService {
    
    func shareMotivation(title: String, motivation: String) {
        let shareText = "\(title)\n\n\(motivation)"
        
        let keyWindow = UIApplication.shared.keyWindow
        if let topViewController = keyWindow?.topViewController {
            let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            topViewController.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
}
