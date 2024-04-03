//
//  GridModel.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation

struct GridType {
    //切割时的块编号
    let gridBlocks: [Int]
    //对应cell的图像编号
    let gridIndex: Int
    init(gridBlocks: [Int], gridIndex: Int) {
        self.gridBlocks = gridBlocks
        self.gridIndex = gridIndex
    }
    
//    let gridModel: Int
}
enum FilterType {
    case origin
    case noir
    case sepiaTone
    case colorControls
    case gaussianBlur
    case vignette
//    case comicEffect
}
