//
//  AppDelegate.swift
//  WeatherApplication
//
//  Created by Shelton on 10/19/17.
//  Copyright © 2017 ThundrCraft. All rights reserved.
//

import UIKit
import XCGLogger
import DCIntrospect_ARC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
     
        // Theme
        setupThemeAppearance()
        
        // Main window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let mainViewController = MainViewController()
        
        // Set the root view controller of the app's window
        window!.rootViewController = mainViewController
        
        // Make the window visible
        window!.makeKeyAndVisible()
        
        // Bootstrap
        //appBootstrap()
 
        
 
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            DCIntrospect.sharedIntrospector().start()
        #endif
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}



// MARK: - Bootstrap

extension AppDelegate {
    
    private func appBootstrap() {
        
        let loadingViewController = (window?.rootViewController as? LoadingViewController) ?? LoadingViewController()
        loadingViewController.startLoading()
        if !(window?.rootViewController is LoadingViewController) {
            window?.rootViewController = loadingViewController
        }
        
showWeather()
    }
    private func showWeather() {
 

        let menuViewController =  MainViewController()
                    let logoutButton = UIBarButtonItem(image: UIImage.init(named: "logout-btn"), style: .Plain, target: menuViewController, action: #selector(MainViewController.didPressRefreshButton(_:)))
                    menuViewController.navigationItem.rightBarButtonItem = logoutButton
                    bootstrapUI(menuViewController)
                    //                    bootstrapUI()
        
    }
    
    
}




