//
//  CoinsModel.swift
//  GidTag
//
//  Created by Tanshuo on 2024/4/2.
//

import Foundation
import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T?) -> Void)?

    init(_ value: T? = nil) {
        self.value = value
    }

    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
        listener(value)
    }
}

class CoinsModel {
    
    static let shared = CoinsModel() // 单例实例

    var coins: Observable<Int> {
        didSet {
            saveCoinsToUserDefaults()
        }
    }

    init(initialCoins: Int = 15) { // 设定一个默认值或者从UserDefaults加载
        let savedCoins = UserDefaults.standard.integer(forKey: coinsKey)
        coins = Observable(savedCoins >= 0 ? savedCoins : initialCoins)
        saveCoinsToUserDefaults()
    }

    func addCoins(_ amount: Int) {
        let currentCoins = coins.value ?? 0
        coins.value = currentCoins + amount
        saveCoinsToUserDefaults()
    }

    func spendCoins(_ amount: Int) {
        let newAmount = (coins.value ?? 0) - amount
        coins.value = newAmount >= 0 ? newAmount : 0
        saveCoinsToUserDefaults()
    }

    private func saveCoinsToUserDefaults() {
        UserDefaults.standard.set(coins.value, forKey: coinsKey)
    }

}
class NetworkActivityIndicatorManager : NSObject {
    
    private static var loadingCount = 0
    
    class func NetworkOperationStarted() {
        if loadingCount == 0 {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    class func networkOperationFinished(){
        if loadingCount > 0 {
            loadingCount -= 1
            
        }
        
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }
    }
}
