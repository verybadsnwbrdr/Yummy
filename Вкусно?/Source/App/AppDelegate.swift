//
//  AppDelegate.swift
//  Вкусно?
//
//  Created by Anton on 19.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let viewController = ViewController()
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
		
		return true
	}
}

