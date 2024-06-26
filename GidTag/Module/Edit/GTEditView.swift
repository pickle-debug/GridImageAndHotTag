//
//  GTEditView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit
class GTEditView:UIView {

    var editTypeBar = UISegmentedControl(items: segmentItem)
    
    
    let filterView = GTFilterView()
    let textView = GTTextView()
    let stickerView = GTStickerView()

    var editTypeView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        self.backgroundColor = .black
        
     
        editTypeBar.selectedSegmentIndex = 0
        editTypeBar.selectedSegmentTintColor = .white
        editTypeBar.backgroundColor = .clear
        addSubview(editTypeBar)
        editTypeBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        editTypeBar.layer.cornerRadius = 12
        editTypeBar.layer.borderColor = UIColor.white.cgColor
        editTypeBar.layer.borderWidth = 2
        editTypeBar.layer.masksToBounds = true
        editTypeBar.addTarget(self, action: #selector(segmentDidchange), for: .valueChanged)
        
        // 定义未选中状态下的文本属性
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#C4C4C4"), // 文本颜色
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold) // 字体大小
        ]

        // 定义选中状态下的文本属性
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black, // 文本颜色
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold) // 字体大小
        ]

        // 应用这些属性到 UISegmentedControl
        editTypeBar.setTitleTextAttributes(normalTextAttributes, for: .normal)
        editTypeBar.setTitleTextAttributes(selectedTextAttributes, for: .selected)

        addSubview(editTypeView)
        editTypeView.backgroundColor = UIColor.init(hexString: "#544F8F")
        editTypeView.layer.cornerRadius = 24
        editTypeView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.7)
            make.top.equalTo(editTypeBar.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(editTypeBar.snp.width)
        }
    
        editTypeView.addSubview(filterView)
        filterView.isHidden = false
        filterView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        editTypeView.addSubview(textView)
        textView.isHidden = true
        textView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        editTypeView.addSubview(stickerView)
        stickerView.isHidden = true
        stickerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
    }
    @objc func segmentDidchange(_ segmented: UISegmentedControl){
        setImageEditUI(index: segmented.selectedSegmentIndex)
    
    }
    func setImageEditUI(index:Int){
        filterView.isHidden = true
        textView.isHidden = true
        stickerView.isHidden = true

        switch index {
        case 0:
            filterView.isHidden = false
        case 1:
            textView.isHidden = false
        case 2:
            stickerView.isHidden = false
        default:
            0
        }
    }
}
