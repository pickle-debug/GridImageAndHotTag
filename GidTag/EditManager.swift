//
//  EditManager.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit

//其实应该是Observer
class EmojiMixManager {
    // 定义一个属性来保存数据
    var index: Int? {
        didSet {
            // 当数据变化时，发送通知
            NotificationCenter.default.post(name: Notification.Name(""), object: nil, userInfo: ["": index])
        }
    }
    
}
