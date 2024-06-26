//
//  Ex+UIImage.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit
extension UIImage {
    func resizedImage(targetSize: CGSize) -> UIImage? {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        return resizedImage
    }
}

extension UIImage {
//    func origin()
    //黑白效果滤镜
    func noir() -> UIImage?
    {
        let imageData = self.pngData()
        let inputImage = CoreImage.CIImage(data: imageData!)
        let context = CIContext(options:nil)
        let filter = CIFilter(name:"CIPhotoEffectNoir")
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        if let outputImage = filter!.outputImage {
            let outImage = context.createCGImage(outputImage, from: outputImage.extent)
            return UIImage(cgImage: outImage!)
        }
        return nil
    }
    
    //棕褐色复古滤镜（老照片效果）
     func sepiaTone() -> UIImage?
     {
         let imageData = self.pngData()
         let inputImage = CoreImage.CIImage(data: imageData!)
         let context = CIContext(options:nil)
         let filter = CIFilter(name:"CISepiaTone")
         filter!.setValue(inputImage, forKey: kCIInputImageKey)
         filter!.setValue(0.8, forKey: "inputIntensity")
         if let outputImage = filter!.outputImage {
             let outImage = context.createCGImage(outputImage, from: outputImage.extent)
             return UIImage(cgImage: outImage!)
         }
         return nil
     }
    func colorControls() -> UIImage? {
        guard let imageData = self.pngData(),
              let inputImage = CIImage(data: imageData) else { return nil }
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIColorControls") {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(1.5, forKey: "inputSaturation") // 饱和度
            filter.setValue(1.0, forKey: "inputBrightness") // 亮度
            filter.setValue(3.0, forKey: "inputContrast") // 对比度
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    func gaussianBlur() -> UIImage? {
        guard let imageData = self.pngData(),
              let inputImage = CIImage(data: imageData) else { return nil }
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIGaussianBlur") {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(10.0, forKey: kCIInputRadiusKey) // 模糊半径
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: inputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    func vignette() -> UIImage? {
        guard let imageData = self.pngData(),
              let inputImage = CIImage(data: imageData) else { return nil }
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIVignette") {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue( 10, forKey: "inputIntensity")
            filter.setValue( 30, forKey: "inputRadius")
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
//    func comicEffect() -> UIImage? {
//        guard let imageData = self.pngData(),
//              let inputImage = CIImage(data: imageData) else { return nil }
//        let context = CIContext(options: nil)
//        if let filter = CIFilter(name: "CIRandomGenerator") {
//            filter.setValue(inputImage, forKey: kCIInputImageKey)
//            if let outputImage = filter.outputImage,
//               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
//                return UIImage(cgImage: cgImage)
//            }
//        }
//        return nil
//    }
//    
    func applyFilter(ofType filterType: FilterType) -> UIImage {
//        guard let image = self else  { return self}
        let filteredImage: UIImage? = {
            switch filterType {
            case .origin: return self
            case .noir:
                return self.noir()!
            case .sepiaTone:
                return self.sepiaTone()!
            case .colorControls:
                return self.colorControls()!
            case .gaussianBlur:
                return self.gaussianBlur()!
            case .vignette:
                return self.vignette()!
//            case .comicEffect:
//                return self.comicEffect()!
            }
        }()
        
        return filteredImage!
        // 假设 yourImageView 是你要应用滤镜的 UIImageView
//        yourImageView.image = filteredImage
    }

    func applyBlackMaskToImage(_ indics:[Int]) -> UIImage? {
        
        let indices = indics
        let partWidth = self.size.width / 3
        let partHeight = self.size.height / 3
        
        // 创建一个基于combinedImage大小的新图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 首先，将原始图片绘制到上下文中
        self.draw(at: .zero)
        
        // 接着，对不在indices中的块应用黑色蒙版
        for index in 0..<9 { // 假设图片被分成了3x3的网格
            if !indices.contains(index) {
                let row = index / 3
                let column = index % 3
                let originX = partWidth * CGFloat(column)
                let originY = partHeight * CGFloat(row)
                let rect = CGRect(x: originX, y: originY, width: partWidth, height: partHeight)
                
                // 在rect区域内填充黑色
                context.setFillColor(UIColor.black.cgColor)
                context.fill(rect)
            }
        }
        
        // 从上下文中获取新的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
