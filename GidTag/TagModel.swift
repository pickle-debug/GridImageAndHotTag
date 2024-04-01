//
//  TagModel.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
// 自定义 Decoder，保持顺序
//class OrderedJSONDecoder: JSONDecoder {
//    override init() {
//        super.init()
//        self.keyDecodingStrategy = .ordered
//    }
//}


// 子标签结构体
struct SubTag: Codable {
    let subTag: String
    let tags: [String]
}

// 顶层标签结构体
struct TopTag: Codable {
    let topTag: String
    let subTags: [SubTag]
}

// JSON 数据对应的结构体
struct DataModel: Codable {
    let data: [TopTag]
}


class TagManager {
    static let shared = TagManager()
    
    var dataModel: DataModel?
    
    init() {
        loadData()
    }
    
    // 加载并解析 JSON 数据
    func loadData() {
        guard let path = Bundle.main.path(forResource: "tag", ofType: "json") else {
            print("JSON 文件未找到")
            return
        }
        
        do {
            // 读取 JSON 文件数据
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
            
            // 解析 JSON 数据为 DataModel 结构体
            let decoder = JSONDecoder()
            let dataModel = try decoder.decode(DataModel.self, from: jsonData)
            
            // 按照 JSON 中的顺序对 subTags 进行排序
            let sortedDataModel = DataModel(data: dataModel.data.map { topTag in
                let sortedSubTags = topTag.subTags.sorted(by: { $0.subTag < $1.subTag })
                return TopTag(topTag: topTag.topTag, subTags: sortedSubTags)
            })
            
            self.dataModel = sortedDataModel
            //                   return sortedDataModel
            
        } catch {
            print("解析失败: \(error)")
            //            return nil
        }
    }
    
    // 获取顶层标签数量
    func numberOfTopTags() -> Int {
        return dataModel?.data.count ?? 0
    }
    
    // 获取指定顶层标签下的子标签数量
    func numberOfSubTags(forTopTagIndex index: Int) -> Int {
        guard let topTags = dataModel?.data else { return 0 }
        guard index < topTags.count else { return 0 }
        return topTags[index].subTags.count
    }
    
    // 获取指定顶层标签名称
    func topTagName(atIndex index: Int) -> String? {
        guard let topTags = dataModel?.data else { return nil }
        guard index < topTags.count else { return nil }
        return topTags[index].topTag
    }
    
    // 获取指定顶层标签下指定子标签名称
    func subTagName(forTopTagIndex topIndex: Int, subTagIndex: Int) -> String? {
        guard let topTags = dataModel?.data else { return nil }
        guard topIndex < topTags.count else { return nil }
        guard subTagIndex < topTags[topIndex].subTags.count else { return nil }
        return topTags[topIndex].subTags[subTagIndex].subTag
    }
}
