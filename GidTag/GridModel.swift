//
//  GridModel.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation

struct GridType {
    let gridBlock: [Int] = []
    let gridType: String
    let gridModel: Int
}
enum FilterType {
    case noir
    case sepiaTone
    case colorControls
    case gaussianBlur
    case highlightShadowAdjust
    case comicEffect
}
