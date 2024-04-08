//
//  GT.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit
class GTSelectableCell:UICollectionViewCell {
    var imageView = UIImageView()
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? 2 : 0
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        layer.cornerRadius = 12
        backgroundColor = .white
        layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
