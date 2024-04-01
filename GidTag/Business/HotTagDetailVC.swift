//
//  HotTagDetailVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class HotTagDetailVC: UIViewController{
    let topTag:TopTag
    var cardView: GTHotTagCardView
    let backgroundView = UIImageView()
    init(topTag: TopTag) {
        self.topTag = topTag
        self.cardView = GTHotTagCardView(frame: .zero, subTag: topTag.subTags[0])
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        self.view.addSubview(backgroundView)
        backgroundView.image = UIImage(named: "background")?.withRenderingMode(.alwaysOriginal)
        backgroundView.contentMode = .scaleAspectFit
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        self.view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalTo(kNavBarFullHeight)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.38)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
