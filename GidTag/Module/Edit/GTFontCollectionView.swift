//
//  GTFontCollectionView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTFontCollectionView:UICollectionView {
    
    let cellHeightSize = kScreenHeight * 0.03
    let cellWidthSize = kScreenWidth * 0.16
    var selectedFont: ((UIFont) -> Void)?
    var fonts: [UIFont] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellWidthSize, height: cellHeightSize) // 设置每个单元格的大小
        flowLayout.minimumInteritemSpacing = 10 // 设置单元格之间的最小间距
        //            flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 设置内容区域的内边距 设置内容区域的内边距
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.showsHorizontalScrollIndicator = false
        self.dataSource = self
        self.delegate = self
        self.register(GTFontCell.self, forCellWithReuseIdentifier: "GTFontCell")
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GTFontCollectionView: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTFontCell", for: indexPath) as! GTFontCell
        cell.text.font = fonts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(fonts[indexPath.item])
//        self.selectedFont = fonts[indexPath.item]
        selectedFont?(fonts[indexPath.item])
        
//        print(selectedFont)
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
