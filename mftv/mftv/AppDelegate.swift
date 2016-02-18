//
//  AppDelegate.swift
//  mftv
//
//  Created by Emiel Lensink on 03/11/15.
//  Copyright © 2015 Emiel Lensink. All rights reserved.
//

import UIKit
import QxKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

		// Configure HTTP
		let httpService = HTTPService.sharedInstance
		
		httpService.host("mooistefotos.nl")
		
		return true
	}

	func application(app: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
		print("Application launched with URL: \(url)")
		return true
	}
	
	func applicationDidReceiveMemoryWarning(application: UIApplication) {
		print("Received memory warning. Flushing image cache.")
		ObjectCache.defaultCache.removeAllObjects()
	}
	
	func applicationWillResignActive(application: UIApplication) {

	}

	func applicationDidEnterBackground(application: UIApplication) {

	}

	func applicationWillEnterForeground(application: UIApplication) {

	}

	func applicationDidBecomeActive(application: UIApplication) {

	}

	func applicationWillTerminate(application: UIApplication) {

	}
}

