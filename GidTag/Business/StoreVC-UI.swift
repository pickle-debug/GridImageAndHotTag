//
//  StoreVC-UI.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/2.
//

import Foundation
import UIKit
extension StoreVC {
    func setUI(){
        self.view.addSubview(Coins100Button)
        self.view.addSubview(Coins200Button)
        self.view.addSubview(Coins500Button)
        self.view.addSubview(Coins1000Button)

        Coins100Button.coinsLabel.text = "\(priceDict[0].coins)coins"
        Coins100Button.priceLabel.text = "$\(priceDict[0].price)"
        Coins100Button.tag = 0
        Coins100Button.addTarget(self, action: #selector(buyCoins), for: .touchUpInside)
        Coins100Button.snp.makeConstraints { make in
            make.top.equalTo(kScreenHeight * 0.47)
            make.width.equalToSuperview().multipliedBy(0.43)
            make.height.equalToSuperview().multipliedBy(0.23)
            make.left.equalTo(16)
        }
        Coins200Button.coinsLabel.text = "\(priceDict[1].coins)coins"
        Coins200Button.priceLabel.text = "$\(priceDict[1].price)"
        Coins200Button.tag = 1
        Coins200Button.addTarget(self, action: #selector(buyCoins), for: .touchUpInside)
        Coins200Button.snp.makeConstraints { make in
            make.top.equalTo(Coins100Button)
            make.width.height.equalTo(Coins100Button)
            make.right.equalTo(-16)
        }
        
        Coins500Button.coinsLabel.text = "\(priceDict[2].coins)coins"
        Coins500Button.priceLabel.text = "$\(priceDict[2].price)"
        Coins500Button.tag = 2
        Coins500Button.addTarget(self, action: #selector(buyCoins), for: .touchUpInside)
        Coins500Button.snp.makeConstraints { make in
            make.top.equalTo(Coins100Button.snp.bottom).offset(16)
            make.width.height.equalTo(Coins100Button)
            make.left.equalTo(Coins100Button)
        }
        
        Coins1000Button.coinsLabel.text = "\(priceDict[3].coins)coins"
        Coins1000Button.priceLabel.text = "$\(priceDict[3].price)"
        Coins1000Button.tag = 3
        Coins1000Button.addTarget(self, action: #selector(buyCoins), for: .touchUpInside)
        Coins1000Button.snp.makeConstraints { make in
            make.top.equalTo(Coins500Button)
            make.width.height.equalTo(Coins100Button)
            make.right.equalTo(Coins200Button)
        }
        
        self.view.addSubview(coinsCountLabel)
        coinsCountLabel.backgroundColor = .black
        coinsCountLabel.textColor = .white
        coinsCountLabel.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        coinsCountLabel.layer.masksToBounds = true
        // 设置自动调整字体大小以适应宽度
        coinsCountLabel.adjustsFontSizeToFitWidth = true
        coinsCountLabel.textAlignment = .center
        // 设置字体缩小的最小比例，这里设为0.5表示最小可以缩小到原字体的50%
        coinsCountLabel.minimumScaleFactor = 0.5
        coinsCountLabel.layer.cornerRadius = kScreenHeight * 0.02
        coinsCountLabel.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.04)
            make.width.equalToSuperview().multipliedBy(0.20)
            make.top.equalTo(kNavBarHeight)
            make.right.equalTo(-20)
        }
        CoinsModel.shared.coins.bind { [weak self] coins in
            DispatchQueue.main.async {
                self?.coinsCountLabel.text = "\(coins ?? 0)"
            }
        }
        
        self.view.addSubview(coinsCountView)
        coinsCountView.image = UIImage(named: "Coins")?.withRenderingMode(.alwaysOriginal)
        coinsCountView.contentMode = .scaleAspectFit
        coinsCountView.snp.makeConstraints { make in
            make.width.height.equalTo(coinsCountLabel.snp.height)
            make.centerY.equalTo(coinsCountLabel)
            make.left.equalTo(coinsCountLabel)
        }
        

    }
}
