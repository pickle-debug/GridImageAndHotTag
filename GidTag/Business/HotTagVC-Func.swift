//
//  HotTagVC-Func.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/1.
//

import Foundation
import UIKit
extension HotTagVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  TagManager.shared.numberOfTopTags()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GTHotTagCell", for: indexPath) as! GTHotTagCell
        let tagName =  TagManager.shared.topTagName(atIndex: indexPath.item)
        cell.imageView.image = UIImage(named: tagName!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topTag = TagManager.shared.dataModel?.data[indexPath.item]
        let nextViewController = HotTagDetailVC(topTag: topTag!)
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
