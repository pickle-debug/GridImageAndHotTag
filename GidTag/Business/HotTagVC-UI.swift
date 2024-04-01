//
//  HotTag-UI.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
extension HotTagVC {
    func setUI(){
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GTHotTagCell.self, forCellWithReuseIdentifier: "GTHotTagCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: cellHeightSize * 0.86, height: cellHeightSize) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 16 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 24
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // 设置内容区域的内边距
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(kNavBarFullHeight)
        }
    }
    
}
