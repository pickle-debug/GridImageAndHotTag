//
//  GTGridCell.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
class GTGridCell:UICollectionViewCell {
    
//    select
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.gray.cgColor
        }
    }
    var image = UIImage()
    
    var imageView: UIImageView{
        let imageView = UIImageView()
        imageView.image = self.image
        return imageView
    }
    
    override init(frame: CGRect) {
//        self.image = image
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        imageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
    }
}
