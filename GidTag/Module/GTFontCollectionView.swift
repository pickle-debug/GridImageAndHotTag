//
//  GTFontCollectionView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTFontCollectionView:UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let cellHeightSize = kScreenHeight * 0.03
    let cellWidthSize = kScreenWidth * 0.16
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.backgroundColor = .white
//        self.layer.cornerRadius = 24
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GTFontCell.self, forCellWithReuseIdentifier: "GTFontCell")
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: cellWidthSize, height: cellHeightSize) // 设置每个单元格的大小
            flowLayout.minimumInteritemSpacing = 10 // 设置单元格之间的最小间距
//            flowLayout.minimumLineSpacing = 10
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 设置内容区域的内边距
        }
    
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTFontCell", for: indexPath) as! GTFontCell
        cell.text.font = fonts[indexPath.item]
        return cell
    }
    
}
class GTFontCell: UICollectionViewCell {
    let text = UILabel()
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 2 : 0
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        addSubview(imageView)
        layer.cornerRadius = 9
        layer.masksToBounds = true
        backgroundColor = .white
        
        text.text = "font"
        text.textColor = .black
        text.textAlignment = .center
//        text.backgroundColor = .white
        addSubview(text)
        text.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.67)
//            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
