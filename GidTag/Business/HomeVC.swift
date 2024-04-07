//
//  HomeVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import Foundation
import UIKit
class HomeVC: UIViewController {
    let nextView = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(nextView)
        nextView.setImage(UIImage(named: "EditEnter"), for: .normal)
        nextView.imageView?.contentMode = .scaleToFill
        nextView.addTarget(self, action: #selector(toNext), for: .touchUpInside)
        nextView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.47)
        }
        // Do any additional setup after loading the view.
    }
    @objc func toNext(){
        var editVC = EditVC()

        editVC.view.backgroundColor = .black
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

