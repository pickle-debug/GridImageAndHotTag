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
    
    var imageView = UIImageView()
    
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
        layer.cornerRadius = 19
        layer.masksToBounds = true
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.76)
            make.width.equalTo(imageView.snp.height)
            make.center.equalToSuperview()
        }
        
    }
}
