//
//  PurchasVC.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/20.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class PurchasVC: UIViewController {

    let iapManager = IAPManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(restoresSuccess), name: NSNotification.Name("RestoresSuccess"), object: nil)
    }
    
    @objc
    func restoresSuccess() {
        
        let alert = UIAlertController(title: nil, message: "復原成功!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
        GlobalModel.shared.isRemoveAD = true
    }
    
    @IBAction func startPurchas(_ sender: UIButton) {
        
        if GlobalModel.shared.isRemoveAD {
            
            let alert = UIAlertController(title: nil, message: "已購買完成.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .default, handler: nil)
            
            alert.addAction(ok)
            
            present(alert, animated: true, completion: nil)
        } else {
            
            iapManager.startPurchase()
        }
    }
    
    @IBAction func restorePurchas(_ sender: UIButton) {
        
        iapManager.restorePurchase()
    }
    
}
