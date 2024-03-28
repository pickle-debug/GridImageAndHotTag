//
//  Constant.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
//MARK: - Purchase
let bundleID = "com.avataredit.emoji"

let purchaseProduct: Set<String> = ["com.addtatto.nicely.100coin","com.addtatto.nicely.200coin","com.addtatto.nicely.500coin","com.addtatto.nicely.1000coin"]
//MARK: - Layout
/// 屏高
let kScreenHeight = UIScreen.main.bounds.size.height
/// 屏宽
let kScreenWidth = UIScreen.main.bounds.size.width
/// 主窗口
public let kWindow = UIApplication.shared.keyWindow ?? UIWindow()
/// 根VC
public let kRootVC = kWindow.rootViewController ?? UIViewController()
/// 动态获取安全区域
var safeAreaInsets: UIEdgeInsets {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? UIEdgeInsets.zero
    } else {
        // 在iOS 11以下，安全区域概念不存在，返回UIEdgeInsets.zero
        return UIEdgeInsets.zero
    }
}
/// 顶部安全高度
let kHeight_SafeTop = safeAreaInsets.top
/// 状态栏高度，iOS 13以后，状态栏高度应通过safeAreaInsets.top获取
let kStatusBarHeight = safeAreaInsets.top
/// 导航栏高度（不包括顶部安全高度）
let kNavBarHeight: CGFloat = 44.0
/// 完整的导航栏高度（包括顶部安全高度）
let kNavBarFullHeight = kStatusBarHeight + kNavBarHeight
/// 底部安全区域高度
let kHomeIndicatorHeight = safeAreaInsets.bottom
/// tabbar高度（包括底部安全区域高度）
let kTabBarHeight = kHomeIndicatorHeight + 49.0
// MARK: - Image
let gridModel: [UIImage] = (1...8).compactMap { UIImage(named: "Grid\($0)") }
let dog: [UIImage] = (0...8).compactMap { UIImage(named: "dog\($0)") }
let cat: [UIImage] = (0...8).compactMap { UIImage(named: "cat\($0)") }
let pig: [UIImage] = (0...8).compactMap { UIImage(named: "pig\($0)") }
let rabbit: [UIImage] = (0...8).compactMap { UIImage(named: "rabbit\($0)") }
