//
//  pageVC.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class PageVC: UIPageViewController {
    
    var viewControllerList: [UIViewController] = [UIViewController]()
    var isScroll = false
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndLoadRewardedAd()
        
        delegate = self
        dataSource = self
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        viewController.delegate = self
        let answerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnswerVC") as! AnswerVC
        
        viewControllerList.append(viewController)
        viewControllerList.append(answerVC)
        
        setViewControllers([viewControllerList.first!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    func createAndLoadRewardedAd() {
        
        #if DEBUG
            rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        #else
//            rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-1223027370530841/3292619156")
        #endif
 
        rewardedAd?.load(GADRequest(), completionHandler: { (error) in
            
            if let error = error {
                print("Loading failed: \(error)")
            } else {
                print("Loading Succeeded")
            }
        })
    }
}

extension PageVC: MainVCDelegate {
    
    func questionSuccess() {
        
        let answerVC = viewControllerList[1] as! AnswerVC
        
        let answerIndex = Int.random(in: 0...answerList.count-1)
        
        answerVC.answerStr = answerList[answerIndex]
        
        if rewardedAd?.isReady == true {
            
            rewardedAd?.present(fromRootViewController: self, delegate: self)
        }
    }
}

extension PageVC: GADRewardedAdDelegate {
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        
        isScroll = true
    }
    /// Tells the delegate that the rewarded ad was presented.
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        print("Rewarded ad presented.")
    }
    /// Tells the delegate that the rewarded ad was dismissed.
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        
        createAndLoadRewardedAd()
    }
    /// Tells the delegate that the rewarded ad failed to present.
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}

extension PageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定上一頁的 index
        let priviousIndex: Int = currentIndex - 1
        
        // 判斷上一頁的 index 是否小於 0，若小於 0 則停留在當前的頁數
        return priviousIndex < 0 ? nil : self.viewControllerList[priviousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if !isScroll {
            
            return nil
        }
        
        isScroll = false
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定下一頁的 index
        let nextIndex: Int = currentIndex + 1
        
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > self.viewControllerList.count - 1 ? nil : self.viewControllerList[nextIndex]
    }
}

extension PageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
    }
}
