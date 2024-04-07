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
    var cardView: GTHotTagCardView!
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    let backgroundView = UIImageView()
    init(topTag: TopTag) {
        self.topTag = topTag
        self.cardView = GTHotTagCardView(frame: .zero, subTag: topTag.subTags[0])
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBarButton = UIButton(type: .custom)
        leftBarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        leftBarButton.tintColor = .black
        leftBarButton.addTarget(self, action: #selector(popRootView), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let titleLabel = UILabel()
        titleLabel.text = "\(topTag.topTag)"
        titleLabel.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        titleLabel.textColor = .white
        self.navigationItem.titleView = titleLabel

        setUI()
        
    }
    func setUI(){
        self.view.addSubview(backgroundView)
        backgroundView.image = UIImage(named: "background")?.withRenderingMode(.alwaysOriginal)
        backgroundView.contentMode = .scaleToFill
        backgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(kNavBarFullHeight)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // 根据 topTag.subTags 的数量动态添加 CardView
             for subTag in topTag.subTags {
                 let cardView = GTHotTagCardView(frame: .zero, subTag: subTag)
                 stackView.addArrangedSubview(cardView)
                 cardView.icon.image = UIImage(named: "\(topTag.topTag)Icon")
                 cardView.snp.makeConstraints { make in
                     make.width.equalToSuperview().multipliedBy(0.9)
                     make.height.equalTo(self.view).multipliedBy(0.42) // 如果是垂直滚动，改为设置高度约束
                 }
             }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func popRootView(){
//        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
