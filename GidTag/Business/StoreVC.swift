//
//  StoreVC.swift
//  GidTag
//
//  Created by Tanshuo on 2024/3/28.
//

import UIKit

class StoreVC: UIViewController {

    let Coins100Button = GTPriceButton()
    let Coins200Button = GTPriceButton()
    let Coins500Button = GTPriceButton()
    let Coins1000Button = GTPriceButton()
    let coinsCountView = UIImageView()
    let coinsCountLabel = UILabel()
    
    var purchaseTagMap: [Int: RegisteredPurchase] = [0:RegisteredPurchase.coins100,
                                                     1:RegisteredPurchase.coins200,
                                                     2:RegisteredPurchase.coins500,
                                                     3:RegisteredPurchase.coins1000]
    var purchaseCoinsCount = Int()

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
