//
//  AppDelegate.swift
//  MeetUpOTown2
//
//  Created by Dean Thibault on 5/9/18.
//  Copyright © 2018 Digital Beans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// load favorites
		Favorites.load()
		
		let mainViewController = MeetupsTableViewController(nibName: "MeetupsTableViewController", bundle: nil)
		let navController = UINavigationController(rootViewController: mainViewController)

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navController
		window?.makeKeyAndVisible()
		
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

	}


}

