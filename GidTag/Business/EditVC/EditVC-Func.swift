//
//  EditVC-func.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
import Photos
import Toast_Swift
//import Mantis
 

extension EditVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func registerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: Notification.Name("stickerIndexChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: Notification.Name("filterTypeChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: Notification.Name("submitTextChange"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(updateImage(_:)), name: Notification.Name("grid"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 显示图片选择器
    @objc func addImage() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.presentPicker()
                }
            }
        } else if status == .authorized {
            self.presentPicker()
        } else {
            // 处理未获得权限的情况
        }
    }
    
    func presentPicker() {
        DispatchQueue.main.async {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    
    // 实现UIImagePickerControllerDelegate方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            // 使用选取的图片作为背景
            self.image = image
            self.imageView.image = image
            self.isSelectedImage = true

        }
    }
    
    @objc func edit(){
        guard (self.gridType != nil) else {
            self.view.makeToast("Please select a grid type for image", duration: 1.5,position: .center)
            return
        }
        if isSelectedImage {
            self.imageView.isUserInteractionEnabled = false
            self.gridCollectionView.isHidden = true
            self.editEnterButton.isHidden = true
            self.editView.isHidden = false
            
//            self.gridCollectionView.selectedGrid = { grid in
////                self.editManager.gridType = grid\
//                print(grid.gridBlocks)
//                self.gridType = grid
//                print(self.gridType?.gridBlocks)
//            }
        } else {
            self.view.makeToast("Please select picture from album first", duration: 1.5,position: .center)
        }
        
    }
    @objc func updateImage(_ notification: Notification){
        guard let userInfo = notification.userInfo else { return }
        
        for (key, value) in userInfo {
            if let keyString = key as? String {
                switch keyString {
                case "sticker":
                    if let sticker = value as? UIImage {
                        stickerView.image = sticker
                        stickerView.isHidden = false
                    }
                case "filterType":
                    if let filterType = value as? FilterType {
                        imageView.image = image.applyFilter(ofType: filterType)
                        print(filterType)
                    }
                case "submitText":
                    if let submitText = value as? GTSubmitText {
                        textView.text = submitText.text
                        textView.font = submitText.font
                        textView.textColor = submitText.color
                        textView.isHidden = false

                    }
//                case "gridType":
//                    if let grid = value as? GridType {
//                        gridType = grid
//                    }
                default:
                    break
                }
            }
        }
    }
    
    // 为单个subview添加拖动手势
    func addGestures(to view: UIView) {
        // 添加拖动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)

        view.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let viewToMove = gesture.view else { return }
        let translation = gesture.translation(in: viewToMove.superview)
        
        if gesture.state == .changed {
            let proposedNewCenter = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
            
            // 获取视图的放大后的实际尺寸
            let scaledWidth = viewToMove.frame.width
            let scaledHeight = viewToMove.frame.height
            
            // 获取父视图的尺寸
//            guard let superviewBounds = imageView.bounds else { return }

            // 计算拖动后视图的边界，以确保不会超出父视图
            let minX = scaledWidth / 2
            let maxX = imageView.bounds.width - minX
            let minY = scaledHeight / 2
            let maxY = imageView.bounds.height - minY
            
            let clampedX = max(minX, min(maxX, proposedNewCenter.x))
            let clampedY = max(minY, min(maxY, proposedNewCenter.y))
            
            viewToMove.center = CGPoint(x: clampedX, y: clampedY)
            gesture.setTranslation(.zero, in: viewToMove.superview)
        }
    }

    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let viewToScale = gesture.view else { return }

        if gesture.state == .began || gesture.state == .changed {
            let scale = gesture.scale
            let currentTransform = viewToScale.transform
            let newTransform = currentTransform.scaledBy(x: scale, y: scale)
            // 使用bounds而非frame，因为bounds不受transform影响
            let newFrame = viewToScale.bounds.applying(newTransform)
            let center = viewToScale.center

            // 计算缩放后视图的中心点到边界的距离
            let left = center.x - newFrame.size.width / 2
            let right = center.x + newFrame.size.width / 2
            let top = center.y - newFrame.size.height / 2
            let bottom = center.y + newFrame.size.height / 2

            // 确保缩放后的视图不会超出父视图的边界
            let fitsInSuperview = left >= 0 && right <= imageView.bounds.width && top >= 0 && bottom <= imageView.bounds.height
            
            if fitsInSuperview {
                viewToScale.transform = newTransform
                gesture.scale = 1.0
            } else {
                // 分解复杂表达式
                let deltaX = (center.x - imageView.bounds.size.width / 2).magnitude
                let deltaY = (center.y - imageView.bounds.size.height / 2).magnitude
                let widthRatio = (imageView.bounds.width - deltaX) / (newFrame.size.width / 2)
                let heightRatio = (imageView.bounds.height - deltaY) / (newFrame.size.height / 2)
                let minRatio = min(widthRatio, heightRatio, 1) // 加上1确保不放大超过原大小

                viewToScale.transform = currentTransform.scaledBy(x: minRatio, y: minRatio)
            }
        }
    }
    @objc func editTap(_ gesture: UITapGestureRecognizer) {
        guard let viewToEdit = gesture.view as? UILabel, let superview = viewToEdit.superview else { return }
        
    }
    

    @objc func popRootView(){
        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc func splitImageViewAndSubViews() {
        imageView.removeGridBorder()
        imageView.layer.borderWidth = 0
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, imageView.image?.scale ?? 1)

        // 递归函数，遍历并绘制在UIImageView范围内的所有视图
        func drawViewsInView(_ view: UIView, baseView: UIImageView) {
            let viewFrameInBaseView = view.convert(view.bounds, to: baseView)
            if baseView.bounds.intersects(viewFrameInBaseView) {
                // 保存当前图形上下文的状态
                UIGraphicsGetCurrentContext()?.saveGState()
                // 移动图形上下文的原点到视图在imageView中的位置
                UIGraphicsGetCurrentContext()?.translateBy(x: viewFrameInBaseView.origin.x, y: viewFrameInBaseView.origin.y)
                
                // 绘制视图到当前的图形上下文，由于上下文原点已调整，视图将在正确的位置绘制
                view.layer.render(in: UIGraphicsGetCurrentContext()!)
                
                // 恢复图形上下文的状态
                UIGraphicsGetCurrentContext()?.restoreGState()
            }
            
            // 遍历子视图，递归调用
            for subview in view.subviews {
                drawViewsInView(subview, baseView: baseView)
            }
        }

        // 从imageView所在的最顶层视图开始遍历
        if let topView = imageView.window {
            drawViewsInView(topView, baseView: imageView)
        }

        // 从当前图形上下文中获取最终的图像
        guard let combinedImage = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()

        if gridType == nil {
                UIImageWriteToSavedPhotosAlbum(combinedImage, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else {
            let indices = gridType!.gridBlocks
            
            let partWidth = combinedImage.size.width / 3
            let partHeight = combinedImage.size.height / 3
            // 请求保存图片到相册的权限
            PHPhotoLibrary.requestAuthorization { status in
                guard status == .authorized else {
                    print("需要访问相册的权限")
                    return
                }
                // 分割并处理选定的部分
                for index in indices {
                    let row = index / 3
                    let column = index % 3
                    let originX = partWidth * CGFloat(column)
                    let originY = partHeight * CGFloat(row)
                    let rect = CGRect(x: originX, y: originY, width: partWidth, height: partHeight)
                    // 切割图片
                    if let croppedCgImage = combinedImage.cgImage?.cropping(to: rect) {
                        let croppedImage = UIImage(cgImage: croppedCgImage)
                        
                        // 在这里，你可以将croppedImage保存到相册或进行其他处理
                        // 例如，保存到相册：
                        DispatchQueue.main.async {
                            UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil)
                        }
                        
                    }
                }
        }

        }
    }
    
    // 保存图片后的回调方法
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 保存失败
            self.view.makeToast("Error Save",duration: 1.0,position: .center)

            print("Error Saving: \(error.localizedDescription)")
        } else {
            // 保存成功
            self.view.makeToast("Image Saved Successfully",duration: 1.0,position: .center)

            print("Image Saved Successfully")
        }
    }
    


}
extension EditVC:UITextFieldDelegate {
    
    // 点击屏幕收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            // 这里假设您已经有一个叫 editAndControlViewBottomConstraint 的底部约束的IBOutlet
            editViewBottomConstraint!.constant = -keyboardHeight // 将EditView上移
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        editViewBottomConstraint!.constant = 0 // 恢复原始位置
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

}
