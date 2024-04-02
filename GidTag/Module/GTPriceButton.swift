//
//  GTPriceButton.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/2.
//

import Foundation
import UIKit
class GTPriceButton:UIButton {
    var priceLabel = UILabel()
    var coinsLabel = UILabel()
    let backgroundImage = UIImageView()

    override init(frame: CGRect) {

        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "Price")?.withRenderingMode(.alwaysOriginal)
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        addSubview(priceLabel)
        addSubview(coinsLabel)
        coinsLabel.textAlignment = .center
        coinsLabel.textColor = .black
        coinsLabel.font = UIFont.italicSystemFont(ofSize: 20)
        coinsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalToSuperview().multipliedBy(0.125)
        }
        
        priceLabel.textAlignment = .center
        priceLabel.textColor = .white
        priceLabel.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(coinsLabel)
            make.bottom.equalTo(-20)
            make.height.equalToSuperview().multipliedBy(0.18)
            make.width.equalToSuperview().multipliedBy(0.6)
        }

    }
}
