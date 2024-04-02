//
//  EditVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit

class EditVC: UIViewController {

    var imageView = UIImageView()
    var image: UIImage? {
        didSet {
            print("update before")
            imageView.image = image
            print("update after")
        }
    }
    var editEnterButton = UIButton()
    var gridCollectionView = GTGridCollectionView()
    var editView = GTEditView()
    var isSelectedImage: Bool = false
    var stickerView = UIImageView()
    var textView = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        image = UIImage(systemName: "photo.badge.plus.fill")
        setUI()
        registerObserver()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
//        setUI()
        // 由于可能多次调用，先移除所有子图层防止重复
        imageView.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() } }
        
        // 现在可以添加网格边框，因为布局已经完成
        imageView.addGridBorder(lineWidth: 2, lineColor: UIColor(hexString: "#8773FB"))
    }

}
