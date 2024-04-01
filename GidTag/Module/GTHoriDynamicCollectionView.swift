//
//  GT.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit

class GTDynamicWidthFlowLayout: UICollectionViewFlowLayout {
    // 预估的宽度，用于初始化布局计算
    let estimatedWidth: CGFloat = 70
    let cellHeight: CGFloat = 31 // 你的cell固定高度

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                let indexPath = layoutAttribute.indexPath
                layoutAttribute.frame = CGRect(x: layoutAttribute.frame.origin.x, y: layoutAttribute.frame.origin.y, width: calculateCellWidth(indexPath: indexPath), height: cellHeight)
            }
        }

        return attributes
    }

    // 根据indexPath计算cell的宽度，这个方法需要你根据cell内部label的文本来动态计算宽度
    func calculateCellWidth(indexPath: IndexPath) -> CGFloat {
        // 示例：根据label的文本长度动态计算宽度
        // 这里只是一个示例，实际上你需要根据你的label文本来计算
        // 可能需要根据你的具体情况访问模型数据来获取文本
        let text = "示例文本" // 应从数据源获取
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width + 20 // 加一些padding
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
class GTHoriDynamicCollectionView: UIView, UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView: UICollectionView!

    var subTag: SubTag
    init(frame: CGRect,subTag: SubTag) {
        self.subTag = subTag
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        let layout = GTDynamicWidthFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100, height: 50) // 使用动态宽度
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(GTDynamicCell.self, forCellWithReuseIdentifier: "GTDynamicCell")
        collectionView.backgroundColor = .white
        addSubview(collectionView)
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
        addSubview(label)
        backgroundColor = UIColor.init(hexString: "#F6F4FF")
        layer.borderColor = UIColor.init(hexString: "#8773FB").cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.masksToBounds = true
        label.textColor = UIColor.init(hexString: "#8773FB")
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
