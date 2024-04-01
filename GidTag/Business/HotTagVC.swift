//
//  HashTagVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import UIKit

class HotTagVC: UIViewController {
    
    let cellHeightSize = kScreenHeight * 0.14
//    let cellWidthSize = kScreenWidth * 0.14

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
//    let jsonManager = TagManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TagManager.shared.loadData()
//        print(jsonManager.numberOfTopTags())
//        print(jsonManager.numberOfSubTags(forTopTagIndex: 3))
        setUI()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

