//
//  EditVC-UI.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
import SnapKit

extension EditVC {
    func setUI(){
        
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(imageView.snp.height)
        }
//        imageView.image = UIImage(systemName: "photo.badge.plus.fill")
        imageView.layer.borderColor = UIColor.init(hexString: "#8773FB").cgColor
        imageView.layer.borderWidth = 2

        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true

        editEnterButton.setImage(UIImage(named: "EnterEdit"), for: .normal)
        self.view.addSubview(editEnterButton)
        editEnterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(52)
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalTo(editEnterButton.snp.height).multipliedBy(5.71)
        }
        editEnterButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        
        self.view.addSubview(gridCollectionView)
        gridCollectionView.isHidden = false
        gridCollectionView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.23)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo( -kScreenHeight * 0.07)
        }
        
        self.view.addSubview(editView)
        editView.isHidden = true
        editView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        imageView.addSubview(stickerView)
        imageView.addSubview(textView)
    }
}
