//
//  GTTextView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTTextView:UIView {
    
    let textField = UITextField()
    let senderButton = UIButton()

    let fontCollection = GTFontCollectionView()
    let colorCollection = GTColorCollectionView()
    
    var submitText: GTSubmitText? {
        didSet {
            updateSubmitText()
        }
    }
//    var selectedFont: UIFont? {
//        didSet {
//            updateSubmitText()
//        }
//    }
//    var selectedColor: UIColor? {
//        didSet {
//            updateSubmitText()
//        }
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        addSubview(textField)
        textField.placeholder = "Please enter text here"
        textField.backgroundColor = .black
        textField.textColor = .white
        textField.layer.cornerRadius = 17
        textField.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.33)
            make.width.equalToSuperview().multipliedBy(0.77)
            make.left.equalTo(10)
            make.top.equalTo(20)
        }
        
        addSubview(senderButton)
        senderButton.backgroundColor = .white
        senderButton.layer.cornerRadius = 10
        senderButton.setTitle("Done", for: .normal)
        senderButton.setTitleColor(.black, for: .normal)
        senderButton.snp.makeConstraints { make in
            make.height.equalTo(textField)
            make.width.equalToSuperview().multipliedBy(0.13)
            make.left.equalTo(textField.snp.right).offset(10)
            make.top.equalTo(textField)
        }
        addSubview(fontCollection)
        fontCollection.fonts = fonts
        fontCollection.snp.makeConstraints { make in
            make.left.equalTo(textField)
            make.right.equalTo(-10)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.top.equalTo(textField.snp.bottom).offset(25)
        }
        fontCollection.selectedFont = { font in
            print(font)
            self.submitText?.font = font
            print(self.submitText?.font)

        }
        addSubview(colorCollection)
        colorCollection.snp.makeConstraints { make in
            make.left.equalTo(textField)
            make.right.equalTo(-10)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.top.equalTo(fontCollection.snp.bottom).offset(25)
        }
        colorCollection.selectedColor = { color in
            print(color)
            self.submitText?.color = color
            print(self.submitText?.color)

        }
    }
    
    func updateSubmitText (){
        print(submitText?.font)
        print(submitText?.color)
        print(submitText?.text)
    }
}
