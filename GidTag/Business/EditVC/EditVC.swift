//
//  EditVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import UIKit

class EditVC: UIViewController {

//    var imageView = UIImageView()
    var imageView: UIImageView{
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.badge.plus.fill")

        imageView.tintColor = .white
        return imageView
    }
    var gridCollectionView = GTGridCollectionView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
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
