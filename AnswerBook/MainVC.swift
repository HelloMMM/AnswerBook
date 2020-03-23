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
    
    @IBOutlet weak var sponsorBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
