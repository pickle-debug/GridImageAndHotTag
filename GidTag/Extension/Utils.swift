//
//  Utils.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/7.
//

import Foundation
import UIKit
public func showFirstTimeAlertIfNeeded(message: String,type:String,ViewController:UIViewController) {
    let hasShownAlertKey = "hasShownFeatureAlert\(type)"
        let hasShownAlert = UserDefaults.standard.bool(forKey: hasShownAlertKey)
        
        if !hasShownAlert {
            // 弹出提示消息
            let alert = UIAlertController(title: "Feature Introduction", message: message, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                UserDefaults.standard.set(true, forKey: hasShownAlertKey)
            }
            alert.addAction(yesAction)
            ViewController.present(alert, animated: true)
        }
    }
