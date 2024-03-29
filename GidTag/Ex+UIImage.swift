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
    func highlightShadowAdjust() -> UIImage? {
        guard let imageData = self.pngData(),
              let inputImage = CIImage(data: imageData) else { return nil }
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIHighlightShadowAdjust") {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            filter.setValue(1.0, forKey: "inputHighlightAmount")
            filter.setValue(0.0, forKey: "inputShadowAmount")
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    func comicEffect() -> UIImage? {
        guard let imageData = self.pngData(),
              let inputImage = CIImage(data: imageData) else { return nil }
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIComicEffect") {
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            if let outputImage = filter.outputImage,
               let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }


}
