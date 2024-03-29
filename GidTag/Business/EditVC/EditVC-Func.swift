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
//    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
//        print("transformation is \(transformation)")
//        print("cropInfo is \(cropInfo)")        
//        dismiss(animated: true)
//
//    }
//    
//    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
//        dismiss(animated: true)
//
//    }
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
            self.imageView.image = image
            self.isSelectedImage = true

        }
    }
    
    @objc func edit(){
        if isSelectedImage {
            self.imageView.isUserInteractionEnabled = false
            self.gridCollectionView.isHidden = true
            self.editEnterButton.isHidden = true
            self.editView.isHidden = false
        } else {
            self.view.makeToast("Please select picture from album firest", duration: 1.5,position: .center)
        }
    }
}
