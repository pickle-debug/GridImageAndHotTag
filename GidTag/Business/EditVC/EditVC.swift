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
    var image = UIImage()
//    var image: UIImage? {
//        didSet {
//            print("update before")
//            imageView.image = image
//            print("update after")
//        }
//    }
    var editEnterButton = UIButton()
    var gridCollectionView = GTGridCollectionView()
    var editView = GTEditView()
    var isSelectedImage: Bool = false
    var stickerView = UIImageView()
    var textView = UILabel()
    var gridType: GridType?
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
    
//    let editManager = GTEditManager()
    var editViewBottomConstraint: NSLayoutConstraint?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerObserver()
        
        let leftBarButton = UIButton(type: .custom)
        leftBarButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        leftBarButton.tintColor = .white
        leftBarButton.addTarget(self, action: #selector(popRootView), for: .touchUpInside)
        let leftItem = UIBarButtonItem(customView: leftBarButton)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let titleLabel = UILabel()
        titleLabel.text = "Grid"
        titleLabel.font = UIFont.systemFont(ofSize: 24,weight: .bold)
        titleLabel.textColor = .white
        self.navigationItem.titleView = titleLabel

        // 创建一个带有自定义图标的UIBarButtonItem
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.down.to.line"), for: .normal) // 使用自己的图标名替换"yourCustomIcon"
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.tintColor = .white
        button.addTarget(self, action: #selector(splitImageViewAndSubViews), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = item
        
    }
    override func viewDidLayoutSubviews() {
//        setUI()
        // 由于可能多次调用，先移除所有子图层防止重复
//        imageView.layer.sublayers?.forEach { if $0 is CAShapeLayer { $0.removeFromSuperlayer() } }
        
        // 现在可以添加网格边框，因为布局已经完成
        imageView.addGridBorder(lineWidth: 2, lineColor: UIColor(hexString: "#8773FB"))
        
        // Calculate the frame to center the imageView within the contentView
//        let size = CGSize(width: 100, height: 100)// Assuming imageView has an intrinsic size
//        print(size)
//        let x = (imageView.bounds.width - size.width) / 2
//        let y = (imageView.bounds.height - size.height) / 2
//        stickerView.frame = CGRect(x: imageView.frame.origin.x + x, y: imageView.frame.origin.y + y, width: size.width, height: size.height)
//        print(x)
//        print(y)
//        print(stickerView.frame)


    }

}
