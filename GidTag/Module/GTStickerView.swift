//
//  File.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTStickerView:UIView {
    
    let CatButton = UIButton()
    let DogButton = UIButton()
    let RabbitButton = UIButton()
    let PigButton = UIButton()

    let padding = 24
    
    let stickersCollectionView = GTStickerCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        addSubview(CatButton)
        addSubview(DogButton)
        addSubview(RabbitButton)
        addSubview(PigButton)
        
        DogButton.setTitle("Dog", for: .normal)
        DogButton.tag = 1
        DogButton.setTitleColor(UIColor.init(hexString: "#9793C0"), for: .normal)
        DogButton.setTitleColor(UIColor.white, for: .selected)
        DogButton.addTarget(self, action: #selector(updateStickers(_:)), for: .touchUpInside)
        DogButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.right.equalTo(self.snp.centerX).offset(-padding)
            make.top.equalTo(15)
        }
        
        CatButton.setTitle("Cat", for: .normal)
        CatButton.tag = 0
        CatButton.setTitleColor(UIColor.init(hexString: "#9793C0"), for: .normal)
        CatButton.isSelected = true
        CatButton.setTitleColor(UIColor.white, for: .selected)
        CatButton.addTarget(self, action: #selector(updateStickers(_:)), for: .touchUpInside)
        CatButton.snp.makeConstraints { make in
            make.height.equalTo(DogButton)
            make.right.equalTo(DogButton.snp.left).offset(-padding)
            make.top.equalTo(DogButton)
        }
        
        RabbitButton.setTitle("Rabbit", for: .normal)
        RabbitButton.tag = 2
        RabbitButton.setTitleColor(UIColor.init(hexString: "#9793C0"), for: .normal)
        RabbitButton.setTitleColor(UIColor.white, for: .selected)
        RabbitButton.addTarget(self, action: #selector(updateStickers(_:)), for: .touchUpInside)

        RabbitButton.snp.makeConstraints { make in
            make.height.equalTo(DogButton)
            make.left.equalTo(self.snp.centerX).offset(padding)
            make.top.equalTo(DogButton)
        }
        
        PigButton.setTitle("Pig", for: .normal)
        PigButton.tag = 3
        PigButton.setTitleColor(UIColor.init(hexString: "#9793C0"), for: .normal)
        PigButton.setTitleColor(UIColor.white, for: .selected)
        PigButton.addTarget(self, action: #selector(updateStickers(_:)), for: .touchUpInside)
        PigButton.snp.makeConstraints { make in
            make.height.equalTo(DogButton)
            make.left.equalTo(RabbitButton.snp.right).offset(padding)
            make.top.equalTo(DogButton)
        }
        
        addSubview(stickersCollectionView)
        stickersCollectionView.images = cat
        stickersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(CatButton.snp.bottom).offset(14)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().offset(-14)
            make.centerX.equalToSuperview()
        }

    }
    @objc func updateStickers(_ sender: UIButton) {
//        sender.setTitleColor(UIColor.init(hexString: "#9793C0"), for: .normal)
//        sender.setTitleColor(UIColor.white, for: .selected)
        CatButton.isSelected = false
        DogButton.isSelected = false
        RabbitButton.isSelected = false
        PigButton.isSelected = false
        
        sender.isSelected = true
        let imageType = stickersTag[sender.tag]
        print(imageType)
        stickersCollectionView.images = (0...8).compactMap { UIImage(named: "\(imageType)\($0)") }
    }
}
