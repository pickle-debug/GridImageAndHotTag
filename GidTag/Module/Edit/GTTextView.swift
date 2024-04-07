//
//  GTTextView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
class GTTextView:UIView,UITextFieldDelegate {
    
    let textField = UITextField()
    let senderButton = UIButton()

    let fontCollection = GTFontCollectionView()
    let colorCollection = GTColorCollectionView()
    
    var submitText: GTSubmitText! = GTSubmitText(text: "",font: UIFont.systemFont(ofSize: 18),color: .black) {
        didSet {
            updateSubmitText()
        }
    }
    let editManager = GTEditManager()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI(){
        addSubview(textField)
//        textField.placeholder = " Please enter text here"
        textField.backgroundColor = .black
        textField.delegate = self
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " Please enter text here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
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
        senderButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
            self.submitText!.font = font
            print(self.submitText!.font)

        }
        addSubview(colorCollection)
        colorCollection.colors = colors
        colorCollection.snp.makeConstraints { make in
            make.left.equalTo(textField)
            make.right.equalTo(-10)
            make.height.equalToSuperview().multipliedBy(0.11)
            make.top.equalTo(fontCollection.snp.bottom).offset(25)
        }
        colorCollection.selectedColor = { color in
            print(color)
            self.submitText!.color = color
            print(self.submitText!.color)
        }
    }
    
    func updateSubmitText() {
        print(submitText!.font)
        print(submitText!.color)
        print(submitText!.text)
        print("submitText Update")
//        editManager.submitText = submitText
    }
    @objc private func submitButtonTapped() {
        
        guard (textField.text != "")  else {
            self.makeToast("You cannot put in empty Label",duration: 1.5,position: .center)
            return
        }
        self.submitText.text = textField.text ?? ""
        editManager.submitText = submitText
        textField.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         print("----信息----", textField.text!,string.count)
         // 长度限制 , string = 0  点击删除键盘
         if textField.text!.count > 20 && string.count != 0 {
             return false
         }
         return true
    }
}
