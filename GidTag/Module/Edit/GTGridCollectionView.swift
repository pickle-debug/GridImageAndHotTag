//
//  File.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit

class GTGridCollectionView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    let cellSize = kScreenWidth * 0.18
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

//    let editManager = GTEditManager()
    var selectedGrid: ((GridType) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        self.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GTGridCell.self, forCellWithReuseIdentifier: "GTGridCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: cellSize, height: cellSize) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 8 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18) // 设置内容区域的内边距
        }
    
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTGridCell", for: indexPath) as! GTGridCell
        cell.imageView.image = gridImages[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGrid?(gridTypes[indexPath.item])
    }
    
}
