//
//  Ex+UIImageView.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/29.
//

import Foundation
import UIKit

extension UIImageView {
    func addGridBorder(lineWidth: CGFloat, lineColor: UIColor) {
        let gridLayer = CAShapeLayer()
        gridLayer.name = "gridLayer" // 设置标识符
        gridLayer.strokeColor = lineColor.cgColor
        gridLayer.lineWidth = lineWidth
        gridLayer.fillColor = nil // 无填充色
        
        let path = UIBezierPath()
        // 计算每一格的尺寸
        let segmentWidth = self.bounds.width / 3
        let segmentHeight = self.bounds.height / 3
        
        // 横线
        for i in 1..<3 {
            path.move(to: CGPoint(x: 0, y: CGFloat(i) * segmentHeight))
            path.addLine(to: CGPoint(x: self.bounds.width, y: CGFloat(i) * segmentHeight))
        }
        
        // 竖线
        for i in 1..<3 {
            path.move(to: CGPoint(x: CGFloat(i) * segmentWidth, y: 0))
            path.addLine(to: CGPoint(x: CGFloat(i) * segmentWidth, y: self.bounds.height))
        }
        
        gridLayer.path = path.cgPath
        
        self.layer.addSublayer(gridLayer)
    }
    func removeGridBorder() {
          self.layer.sublayers?.forEach {
              if $0.name == "gridLayer" {
                  $0.removeFromSuperlayer()
              }
          }
      }
}
extension UIImageView {
    func splitImageIntoGrid(indexes: [Int]) -> [UIImage]? {
        guard let image = self.image else { return nil }
        var images: [UIImage] = []
        
        let size = CGSize(width: image.size.width / 3, height: image.size.height / 3)
        
        for index in indexes {
            let row = (index - 1) / 3
            let column = (index - 1) % 3
            
            let originX = size.width * CGFloat(column)
            let originY = size.height * CGFloat(row)
            let rect = CGRect(x: originX, y: originY, width: size.width, height: size.height)
            
            if let cgImg = image.cgImage?.cropping(to: rect) {
                images.append(UIImage(cgImage: cgImg))
            }
        }
        
        return images
    }
}
extension UIImageView {
    func setImageSizeRatio(centeredWithRatio ratio: CGFloat) {
        guard let image = self.image else { return }

        // 设置imageView的contentMode为scaleAspectFit，保证图片比例不变
        self.contentMode = .scaleAspectFit

        // 计算基于比例的新尺寸
        let newWidth = self.bounds.width * ratio
        let newHeight = self.bounds.height * ratio
        let newSize = CGSize(width: newWidth, height: newHeight)

        // 使用UIGraphicsImageRenderer调整图片大小
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }

        // 将调整后的图片设置回imageView
        self.image = resizedImage

        // 根据新的尺寸调整imageView的frame，使其位于中央
        let newX = (self.bounds.width - newWidth) / 2
        let newY = (self.bounds.height - newHeight) / 2
        self.frame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
}
