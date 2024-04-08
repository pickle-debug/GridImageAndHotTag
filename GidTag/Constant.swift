//
//  Constant.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
//MARK: - Purchase
let bundleID = "com.addtatto.nicely"

let purchaseProduct: Set<String> = ["com.addtatto.nicely.100coin","com.addtatto.nicely.200coin","com.addtatto.nicely.500coin","com.addtatto.nicely.1000coin"]

//MARK: purchaseId的value的映射
enum RegisteredPurchase : String {
    case coins100 = "100coin"
    case coins200 = "200coin"
    case coins500 = "500coin"
    case coins1000 = "1000coin"

}

let priceDict: [(coins: Int, price: String)] = [
    (100, "2.99"),
    (200, "4.99"),
    (500, "9.99"),
    (1000, "14.99")
]

let coinsKey = "userCoins"
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
let gridImages: [UIImage] = (1...8).compactMap { UIImage(named: "Grid\($0)") }
let dog: [UIImage] = (0...8).compactMap { UIImage(named: "Dog\($0)") }
let cat: [UIImage] = (0...8).compactMap { UIImage(named: "Cat\($0)") }
let pig: [UIImage] = (0...8).compactMap { UIImage(named: "Pig\($0)") }
let rabbit: [UIImage] = (0...8).compactMap { UIImage(named: "Rabbit\($0)") }

let segmentItem = ["Filter","Text","Sticker"]

let filterOriginImage = UIImage(named: "FilterOriginImage")!
let filterTypes: [FilterType] = [.origin,.noir, .sepiaTone, .colorControls, .gaussianBlur, .vignette]

let fonts: [UIFont] = [
    UIFont.systemFont(ofSize: 18, weight: .semibold),
//    UIFont(name:"Red Rose-Bold",size: 18)!,
    UIFont.boldSystemFont(ofSize: 18),
    UIFont.italicSystemFont(ofSize: 18),
//    UIFont(name:"Redressed-Regular",size: 18)!,
//    UIFont(name:"Pathway Gothic One-Regular",size: 18)!,
    UIFont(name:"EuphemiaUCAS",size: 18)!,
    UIFont(name:"Didot-Italic",size: 18)!,
//    UIFont(name:"Galvji",size: 18)!,
    UIFont(name:"Futura-MediumItalic",size: 18)!
//    UIFont(name:"CourierNewPSMT",size: 18)!
//    UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .regular)
]
// 创建字体颜色
let colors: [UIColor] = [UIColor.init(hexString: "#A9A9A9"),UIColor.init(hexString: "#D18585"),UIColor.init(hexString: "#7695E5"),UIColor.init(hexString: "#E576B9"),UIColor.init(hexString: "#D5E576"),UIColor.init(hexString: "#E59E76"),UIColor.init(hexString: "#A7E576"),UIColor.init(hexString: "#76E5D8"),UIColor.init(hexString: "#76A3E5"),UIColor.init(hexString: "#FE7062")]
let stickersTag: [String] = ["Cat","Dog","Rabbit","Pig"]

let gridTypes: [GridType] = [GridType(gridBlocks: [0,1,2,3,4,5,6,7,8], gridIndex: 0),
                             GridType(gridBlocks: [1,3,4,5,7], gridIndex: 1),
                             GridType(gridBlocks: [1,2,4,5,7,8], gridIndex: 2),
                             GridType(gridBlocks: [0,1,2,3,4,5], gridIndex: 3),
                             GridType(gridBlocks: [0,1,3,4,6,7], gridIndex: 4),
                             GridType(gridBlocks: [0,1,3,4], gridIndex: 5),
                             GridType(gridBlocks: [1,2,4,5,6,7,8], gridIndex: 6),
                             GridType(gridBlocks: [0,1,2,3,4,5,6], gridIndex: 7)]

