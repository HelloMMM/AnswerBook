//
//  IAPManager.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/11.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import StoreKit

class IAPManager: NSObject {

    let productID = "HelloM.AnswerBook.item01"
    static let shared = IAPManager()
    var reuqest: SKProductsRequest!
    var products: [SKProduct] = []
    
    override init() {
        super.init()
        
        if SKPaymentQueue.canMakePayments() {
            
            let products = NSSet(array: [productID])
            
            reuqest = SKProductsRequest(productIdentifiers: products as! Set<String>)
            reuqest.delegate = self
            reuqest.start()
        }
        
        SKPaymentQueue.default().add(self)
    }
    
    func startPurchase() {
        
        let payment = SKPayment(product: products[0])
        SKPaymentQueue.default().add(payment)
    }
}

extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    
        for transaction: SKPaymentTransaction in SKPaymentQueue.default().transactions {
            
            SKPaymentQueue.default().finishTransaction(transaction)
        }
        
        if response.products.count != 0 {
            
            for product: SKProduct in response.products {
                        
                print("---------商品資訊---------")
                print("商品標题: \(product.localizedTitle)")
                print("商品描述: \(product.localizedDescription)")
                print("商品價格: \(product.price)")
                print("商品ID: \(product.productIdentifier)")
                print("---------商品資訊---------")
                
                products.append(product)
            }
        }
        
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction: SKPaymentTransaction in transactions {
            
            if transaction.payment.productIdentifier == productID {
                
                switch transaction.transactionState {
                case .purchased:
                    print("交易成功")
                    
                    GlobalModel.shared.isRemoveAD = true
                    UserDefaults.standard.set(true, forKey: "isRemoveAD")
                    NotificationCenter.default.post(name: Notification.Name("RemoveAD"), object: nil)
                    SKPaymentQueue.default().finishTransaction(transaction)
                case .purchasing:
                    print("交易中")
                case .failed:
                    print("交易失敗")
                    
                    SKPaymentQueue.default().finishTransaction(transaction)
                    if let error = transaction.error as? SKError {
                        switch error.code {
                        case .paymentCancelled:
                            print("Transaction Cancelled: \(error.localizedDescription)")
                        case .paymentInvalid:
                            print("Transaction paymentInvalid: \(error.localizedDescription)")
                        case .paymentNotAllowed:
                            print("Transaction paymentNotAllowed: \(error.localizedDescription)")
                        default:
                            print("Transaction: \(error.localizedDescription)")
                        }
                    }
                case .restored:
                    print("復原成功...")
                default:
                    print(transaction.transactionState.rawValue)
                }
            }
        }
    }
}
