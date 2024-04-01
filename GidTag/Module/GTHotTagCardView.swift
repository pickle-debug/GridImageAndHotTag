//
//  Hot.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation

import UIKit
class GTHotTagCardView:UIView {
    
    let icon = UIImageView()
    let subTagName = UILabel()
    let tagCount = UILabel()
    let dividingLine = UIView()
    let subTag: SubTag
    
    let collectionView: GTHoriDynamicCollectionView
    let copyButton = UIButton()
    init(frame: CGRect,subTag: SubTag) {
        self.subTag = subTag
        self.collectionView = GTHoriDynamicCollectionView(frame: .zero, subTag: subTag)
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        layer.cornerRadius = 21
        backgroundColor = .white
        
        addSubview(dividingLine)
        dividingLine.backgroundColor = .black
        dividingLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(0.9)
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        
        
        addSubview(icon)
        icon.image = UIImage(named: "\(subTag.subTag)Icon")
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.07)
            make.width.equalTo(icon.snp.height)
            make.bottom.equalTo(dividingLine.snp.top).offset(-10)
            make.left.equalTo(dividingLine)
        }
        
        addSubview(subTagName)
        subTagName.text = subTag.subTag
        subTagName.textColor = .black
        subTagName.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        subTagName.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(12)
            make.width.equalTo(80)
            make.centerY.equalTo(icon)
            make.height.equalTo(icon)
        }
        addSubview(tagCount)
        tagCount.text = "\(subTag.tags.count)"
        tagCount.textColor = UIColor.init(hexString: "#646464")
        tagCount.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        tagCount.snp.makeConstraints { make in
            make.centerY.equalTo(icon)
            make.right.equalTo(dividingLine)
        }
    
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        addSubview(copyButton)
        copyButton.setTitle("Copy", for: .normal)
        copyButton.setImage(UIImage(named: "Copy"), for: .normal)
        copyButton.tintColor = .white
        copyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
        copyButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview().multipliedBy(0.14)
//            make.
        }
    }
}
