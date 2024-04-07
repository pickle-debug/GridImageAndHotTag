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
            self.view.makeToast("Please allow album permission to add photo for editing.", duration: 1.5,position: .center)
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
            self.imageView.image = image.applyBlackMaskToImage(gridType!.gridBlocks)
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
                        textView.sizeToFit() // 自适应内容
                    }
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
            
            // 考虑到缩放后的视图尺寸
            let scaledWidth = viewToMove.frame.width
            let scaledHeight = viewToMove.frame.height
            
            // 通过imageView的frame来确定边界
            let minX = imageView.frame.minX + scaledWidth / 2
            let maxX = imageView.frame.maxX - scaledWidth / 2
            let minY = imageView.frame.minY + scaledHeight / 2
            let maxY = imageView.frame.maxY - scaledHeight / 2
            
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
            
            // 使用临时变换应用缩放，预测缩放后的frame
            let tempTransform = viewToScale.transform // 保存当前变换状态
            viewToScale.transform = newTransform // 应用新变换以预测新frame
            let scaledFrame = viewToScale.frame // 获取预测的新frame
            viewToScale.transform = tempTransform // 恢复原变换状态
            
            // 判断缩放后的视图是否完全位于imageView内部
            if imageView.bounds.contains(scaledFrame) {
                // 应用新变换
                viewToScale.transform = newTransform
            } else {
                // 如果新的缩放会导致视图超出imageView，寻找一个合适的缩放因子使视图适应imageView
                let fitScaleX = imageView.bounds.width / viewToScale.frame.width
                let fitScaleY = imageView.bounds.height / viewToScale.frame.height
                let minScale = min(fitScaleX, fitScaleY, scale)
                
                let adjustedTransform = currentTransform.scaledBy(x: minScale, y: minScale)
                viewToScale.transform = adjustedTransform
            }
            gesture.scale = 1.0
        }
    }
    
    
    
    @objc func editTap(_ gesture: UITapGestureRecognizer) {
        guard let viewToEdit = gesture.view as? UILabel, let superview = viewToEdit.superview else { return }
        editView.editTypeBar.selectedSegmentIndex = 1
        
    }
    
    
    @objc func popRootView(){
        if editView.isHidden == false {
            self.imageView.isUserInteractionEnabled = true
            self.gridCollectionView.isHidden = false
            self.editEnterButton.isHidden = false
            self.editView.isHidden = true
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
  
    }
    
    @objc func splitImageViewAndSubViews() {
        
        guard self.imageView.image != UIImage(systemName: "plus") else {
            self.view.makeToast("There have no image can be edit,please select image first.",duration: 2.0,position: .center)
            return
        }
    
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
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        guard let coinsValue = CoinsModel.shared.coins.value, coinsValue >= 5 else {
                            self.view.makeToast("Insufficient coins, please go to the store to purchase coins.",duration: 1.0,position: .center)
                            return }
                        let message = "Do you want to spend 5 coins to save the image?"
                        let alert = UIAlertController(title: "Save Image", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self] _ in
                            CoinsModel.shared.spendCoins(5)
                            self!.slipImageToSave(indices,partWidth,partHeight,combinedImage)
                            self!.imageView.layer.borderWidth = 2

                        }))
                        self.present(alert, animated: true)

                    case .denied, .restricted, .limited:
                        // 无权限
                        self.view.makeToast("Photo library access denied or restricted.", title: "Save failed")
                        
                        print("Photo library access denied or restricted.")
                    default:
                        // 未决定，一般不会执行到这里
                        break
                    }
                }
                
            }
            
        }
    }
    
    func slipImageToSave(_ indices: [Int],_ partWidth: CGFloat,_ partHeight: CGFloat,_ combinedImage: UIImage){
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
                    UIImageWriteToSavedPhotosAlbum(croppedImage, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    self.navigationController?.view.makeToast("Image Saved Successfully",duration: 1.0,position: .center)
                }                
            }
        }
    }
 

    // 保存图片后的回调方法
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 保存失败
            self.view.makeToast("Oops!,Error Saving: \(error.localizedDescription)",duration: 1.0,position: .center)
            
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
