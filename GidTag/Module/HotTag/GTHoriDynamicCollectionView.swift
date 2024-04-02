//
//  GT.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit

class GTHoriDynamicCollectionView: UIView, UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView: UICollectionView!

    var subTag: SubTag
    var cellHeight = kScreenHeight * 0.03
    init(frame: CGRect,subTag: SubTag) {
        self.subTag = subTag
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
//        let layout = GTDynamicWidthFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 60, height: cellHeight)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumInteritemSpacing = 10 // 设置单元格之间的最小间距
            flowLayout.minimumLineSpacing = 10
        }
        collectionView.dataSource = self
        collectionView.register(GTDynamicCell.self, forCellWithReuseIdentifier: "GTDynamicCell")
        collectionView.backgroundColor = .white
        addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subTag.tags.count // 示例数据数量
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTDynamicCell", for: indexPath) as! GTDynamicCell
        // 配置cell...
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        cell.label.text = "\(subTag.tags[indexPath.item])"

//        cell.contentView.addSubview(label)
        return cell
    }
}
class GTDynamicCell: UICollectionViewCell {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.contentView.addSubview(label)
        backgroundColor = UIColor.init(hexString: "#F6F4FF")
        layer.borderColor = UIColor.init(hexString: "#8773FB").cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: "#8773FB")
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.frame = self.contentView.bounds

//        label.snp.makeConstraints { make in
//            make.top.bottom.left.right.equalToSuperview()
//        }
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = self.label.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16,weight: .medium)]) ?? CGSize.zero
          let att = super.preferredLayoutAttributesFitting(layoutAttributes);
          att.frame = CGRect(x: 0, y: 0, width: size.width+10, height: 31)
          self.label.frame = CGRect(x: 0, y: 0, width: att.frame.size.width, height: 31)
          return att;
      }
}
