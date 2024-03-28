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
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(imageView.snp.width)
        }
//        imageView.image = UIImage(systemName: "photo.badge.plus.fill")
//        imageView.tintColor = .red
        self.view.addSubview(gridCollectionView)
        gridCollectionView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.23)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.bottom.equalTo(kScreenHeight * 0.07)

        }
    }
}
