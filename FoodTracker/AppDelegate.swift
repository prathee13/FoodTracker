//
//  @Name: AppDelegate.swift
//  @Purpose: To create a window where the contents of the application are drawn and to understand the transitions.
//          by creating an entry point
//
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-22.
//
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?  //storing the reference to the app's window


    /*
     
     The below listed functions help the applicaiton object in communicating with the application delegate
    during transition.
    
    Each of these methods have a default behaviour.
 
    */
    
    /*
     Informs a set of activities that are to be done when the application launches.
     
     - Parameter recipient: Application Launching Options
     
     - Returns: A boolean value - true, when the application is launched.
     
     */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    /*
     Function to pause ongoing tasks either voluntarily by the user or de to some other interruptions such as
       receving a text message or a call.
     
     - Parameter recipient: UIApplication Object
     
     */
    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    /*
     Function to keep the application running in the background (if permitted).
     In such a case, this function is run, instead of terminating.
     
     - Parameter recipient: UI application.
  
     */
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    /*
   Function to enter the foreground from the background
     
     - Parameter recipient: UI application object
     
     */
    
    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    /*
     Function to restart any activities that were paused previously.
     
     - Parameter recipient: UI Application object
     
     */

    func applicationDidBecomeActive(_ application: UIApplication) {
  
    }

    /**
     Function that saves the necessary chnages made b ythe user before quitting.
     
     - Parameter recipient: UI Application Object
     
     */
    func applicationWillTerminate(_ application: UIApplication) {
      
    }


}

