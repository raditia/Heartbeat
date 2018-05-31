//
//  TabBarController.swift
//  PJPB Mobile App
//
//  Created by Raditia Madya on 26/05/18.
//  Copyright © 2018 Universitas Gadjah Mada. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
	
	func setupTabBar() {
		
		let eventVC = EventViewController()
		
		eventVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
		
		let controller = [eventVC]
		
		viewControllers = controller
		viewControllers = controller.map { UINavigationController(rootViewController: $0) }
		
		let tabBarTintColor = UIColor(rgb: 0xB73D48)
		
		UITabBar.appearance().tintColor = tabBarTintColor
	}

}


