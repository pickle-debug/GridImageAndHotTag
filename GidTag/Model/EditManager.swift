//
//  EditManager.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit


class GTEditManager {
    // 定义一个属性来保存数据
    var sticker: UIImage? {
        didSet {
            // 当数据变化时，发送通知
            NotificationCenter.default.post(name: Notification.Name("stickerIndexChange"), object: nil, userInfo: ["sticker": sticker])
        }
    }
    var filterType: FilterType? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("filterTypeChange"), object: nil, userInfo: ["filterType": filterType])
        }
    }
    var submitText: GTSubmitText? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("submitTextChange"), object: nil, userInfo: ["submitText": submitText])

        }
    }
    
}
class GTSubmitText {
    var text = String()
    var font = UIFont()
    var color = UIColor()
}
