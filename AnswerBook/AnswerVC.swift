//
//  answerVC.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class AnswerVC: UIViewController {
    
    @IBOutlet weak var answerLab: UILabel!
    @IBOutlet weak var answerEnLab: UILabel!
    var answerStr = "您還未誠心發問，\n請返回重新來過."
    var answerEn = "You have not sincere questions,\n please return to start over."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answerLab.text = answerStr
        answerEnLab.text = answerEn
    }
}
