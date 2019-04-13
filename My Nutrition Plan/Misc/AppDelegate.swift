 //
//  AppDelegate.swift
//  My Nutrition Plan
//
//  Created by Andris Akačenoks on 15/05/2018.
//  Copyright © 2018 Andris Akačenoks. All rights reserved.
//

import UIKit
import Firebase
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if launchedBefore  {
            print("This is not first launch.")
        } else {
            print("This is first launch.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // change 2 to desired number of seconds
                let vc :UserParamsVC = mainStoryboard.instantiateViewController(withIdentifier: "UserParamsVC") as! UserParamsVC
                self.window?.makeKeyAndVisible()
                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                UserDefaults.standard.synchronize()
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PersistenceService.saveContext()
    }
}

