//
//  GTFilterView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit
class GTFilterView:UIView,UICollectionViewDelegate,UICollectionViewDataSource {
 
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellSize = kScreenHeight * 0.11

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 24
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GTSelectableCell.self, forCellWithReuseIdentifier: "GTSelectableCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: cellSize, height: cellSize) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 16 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 16
            flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // 设置内容区域的内边距
        }
    
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTSelectableCell", for: indexPath) as! GTSelectableCell
        let selectedFilterType = filterTypes[indexPath.item]
    
//        applyFilter(ofType: selectedFilterType)
        return cell
    }
//    func applyFilter(ofType filterType: FilterType) {
//        guard let originalImage = UIImage(named: "cat8") else { return }
//        let filteredImage: UIImage? = {
//            switch filterType {
//            case .noir:
//                return originalImage.noir()
//            case .sepiaTone:
//                return originalImage.sepiaTone()
//            case .colorControls:
//                return originalImage.colorControls()
//            case .gaussianBlur:
//                return originalImage.gaussianBlur()
//            case .highlightShadowAdjust:
//                return originalImage.highlightShadowAdjust()
//            case .comicEffect:
//                return originalImage.comicEffect()
//            }
//        }()
//        // 假设 yourImageView 是你要应用滤镜的 UIImageView
//        yourImageView.image = filteredImage
//    }
//    
}
