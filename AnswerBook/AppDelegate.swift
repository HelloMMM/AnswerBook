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
class AppDelegate: UIResponder, UIApplicationDelegate {
    
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
//            let uploadTask = answerListReference.putData(data, metadata: nil) { (metadata, error) in
//
//            }
//        } catch {
//            print("")
//        }
//
//        #endif
        
        answerEnListReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {

            } else {

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
            if error != nil {

            } else {

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
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

