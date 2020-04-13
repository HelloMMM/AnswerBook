//
//  AppDelegate.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LaunchScreenDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let storage = Storage.storage()
        let answerListReference = storage.reference(forURL: "gs://answerbook-f4a2c.appspot.com/answerList.json")
        let answerEnListReference = storage.reference(forURL: "gs://answerbook-f4a2c.appspot.com/answerEnList.json")

//        #if DEBUG
//
//        if !JSONSerialization.isValidJSONObject(answerList) {
//
//        }
//
//        let dic = ["answerList": answerList]
//
//        do {
//            let data = try JSONSerialization.data(withJSONObject: dic, options: [.prettyPrinted])
//            let decoded = try JSONSerialization.jsonObject(with: data, options: [])
//
//            let uploadTask = answerListReference.putData(data, metadata: nil) { (metadata, error) in
//
//            }
//        } catch {
//            print("")
//        }
//
//        #endif
        
        answerEnListReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error == nil {

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                    let dic = json as! Dictionary<String,Any>

                    answerEnList = dic["answerEnList"] as! Array<String>
                } catch {

                    print("error")
                }
            }
        }

        answerListReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error == nil {

                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                    let dic = json as! Dictionary<String,Any>

                    answerList = dic["answerList"] as! Array<String>
                } catch {

                    print("error")
                }
            }
        }
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        if let isRemoveAD = UserDefaults.standard.object(forKey: "isRemoveAD") as? Bool {
            
            GlobalModel.shared.isRemoveAD = isRemoveAD
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LaunchScreen") as! LaunchScreen
        vc.delegate = self
        
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .unspecified
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    
    func enterMain() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
    }
}

