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
        imageView.image = UIImage(systemName: "plus")
        let imageViewSize = CGSize(width: kScreenHeight * 0.4, height: kScreenHeight * 0.4)
        imageView.frame = CGRect(x: 20, y: kNavBarFullHeight, width: imageViewSize.width, height: imageViewSize.height)
        imageView.center.x = self.view.center.x
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
        self.gridCollectionView.selectedGrid = { grid in
//                self.editManager.gridType = grid\
            print(grid.gridBlocks)
            self.gridType = grid
            print(self.gridType?.gridBlocks)
        }
        
        self.view.addSubview(editView)
        editView.isHidden = true
        editView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        editViewBottomConstraint = editView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        editViewBottomConstraint?.isActive = true


        self.view.addSubview(stickerView)
        stickerView.image = cat[0]
        stickerView.isHidden = true
//        imageView.isUserInteractionEnabled = true // 允许imageView接收用户交互

        // 为stickerView和textView创建新的手势识别器实例
        let stickerPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let stickerPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        stickerView.addGestureRecognizer(stickerPanGesture)
        stickerView.isUserInteractionEnabled = true // 允许imageView接收用户交互
        stickerView.addGestureRecognizer(stickerPinchGesture)
        let stickerViewSize = CGSize(width: 100, height: 100)// Assuming imageView has an intrinsic size
        let x = (imageView.bounds.width - stickerViewSize.width) / 2
        let y = (imageView.bounds.height - stickerViewSize.height) / 2
        stickerView.frame = CGRect(x: x, y: y, width: stickerViewSize.width, height: stickerViewSize.height)

        self.view.addSubview(textView)
        textView.text = "default"
        textView.isHidden = true
        textView.isUserInteractionEnabled = true // 允许imageView接收用户交互

        let textPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        let textPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        let textTapGesture = UIPinchGestureRecognizer(target: self, action: #selector(editTap(_:)))

        textView.addGestureRecognizer(textPanGesture)
        textView.addGestureRecognizer(textPinchGesture)
        textView.addGestureRecognizer(textTapGesture)
        
        let textViewSize = CGSize(width: imageView.bounds.width, height: 100)// Assuming imageView has an intrinsic size
        textView.frame.origin = CGPoint(x: imageView.center.x - 100, y: imageView.center.y)
        textView.frame.size.width = min(textView.frame.size.width, imageView.bounds.width / 2)
        textView.numberOfLines = 0 // 允许多行显示
        self.view.bringSubviewToFront(editView)
    }

}
