//
//  ViewController.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import UICircularProgressRing

protocol MainVCDelegate {
    func questionSuccess()
}

class MainVC: UIViewController {

    @IBOutlet weak var circularProgressRing: UICircularProgressRing!
    @IBOutlet weak var startBtn: UIButton!
    var circularProgressRingValue: CGFloat = 0
    var timer: Timer?
    var isSuccess = false
    var delegate: MainVCDelegate?
    var iapManager = IAPManager.shared
    @IBOutlet weak var sponsorBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        if GlobalModel.shared.isRemoveAD {
            
            sponsorBtn.isHidden = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAD), name: NSNotification.Name("RemoveAD") , object: nil)
    }
    
    @objc func removeAD(notification: NSNotification) {
            
        sponsorBtn.isHidden = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
//        print(traitCollection.userInterfaceStyle.rawValue)
    }
    
    @IBAction func startProgress(_ sender: UIButton) {
        
        circularProgressRing.startProgress(to: 100, duration: 5) {
            
            self.isSuccess = true
            self.startBtn.setTitle("完成", for: .normal)
        }
    }
    
    @IBAction func stopProgress(_ sender: UIButton) {
        
        if isSuccess {
            
            delegate?.questionSuccess()
        }
            
        circularProgressRing.startProgress(to: 0, duration: 1)
        startBtn.setTitle("解", for: .normal)
        self.isSuccess = false
    }
    
    @IBAction func sponsorClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "支持", message: "是否願意花33$支持這個APP,\n可去除廣告.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "好", style: .default) { (action) in
            
            self.iapManager.startPurchase()
        }
        
        let no = UIAlertAction(title: "取消", style: .default, handler: nil)
        
        alert.addAction(no)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
