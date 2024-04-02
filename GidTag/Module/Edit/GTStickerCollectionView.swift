//
//  GTStickerCollectionView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTStickerCollectionView:UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let cellSize = kScreenHeight * 0.09
    var images: [UIImage] = cat {
        didSet {
            collectionView.reloadData()
        }
    }
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.backgroundColor = .clear
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GTSelectableCell.self, forCellWithReuseIdentifier: "GTSelectableCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.itemSize = CGSize(width: cellSize, height: cellSize) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 8 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 16
            flowLayout.sectionInset = UIEdgeInsets(top: 14, left: 15, bottom: 0, right: 15) // 设置内容区域的内边距
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTSelectableCell", for: indexPath) as! GTSelectableCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
}

