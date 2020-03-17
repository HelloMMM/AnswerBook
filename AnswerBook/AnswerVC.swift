//
//  answerVC.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AnswerVC: UIViewController {
    
    @IBOutlet weak var answerLab: UILabel!
    @IBOutlet weak var answerEnLab: UILabel!
    var answerStr = "您還未誠心發問，\n請返回重新來過."
    var answerEn = "You have not sincere questions,\n please return to start over."
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(removeAD), name: NSNotification.Name("RemoveAD") , object: nil)
        
    }
    
    @objc func removeAD(notification: NSNotification) {
            
        bannerView.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        answerLab.text = answerStr
        answerEnLab.text = answerEn
        
    }
    
    func addBannerViewToView() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
        
        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-1223027370530841/3835754064"
        #endif

        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.frame = CGRect(x: 0, y: view.frame.height-bannerView.frame.height, width: view.frame.width, height: bannerView.frame.height)
        view.addSubview(bannerView)
    }
}

extension AnswerVC: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
