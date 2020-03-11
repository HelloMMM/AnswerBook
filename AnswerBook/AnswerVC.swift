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
    var answerStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answerLab.text = answerStr
    }
}
