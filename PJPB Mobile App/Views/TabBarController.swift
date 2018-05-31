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

		let eventVC = EventViewController(nibName: "EventViewController", bundle: nil)
		let newEventVC = NewEventViewController(nibName: "NewEventViewController", bundle: nil)
		
		eventVC.tabBarItem = UITabBarItem(title: "Events",
										  image: UIImage(named: "list"),
										  tag: 1)
		newEventVC.tabBarItem = UITabBarItem(title: "Add event",
											 image: UIImage(named: "plus"),
											 tag: 2)
		
		let controller = [eventVC, newEventVC]
		
		viewControllers = controller
		viewControllers = controller.map { UINavigationController(rootViewController: $0) }
		
		let tabBarTintColor = UIColor(rgb: 0xB73D48)
		
		UITabBar.appearance().tintColor = tabBarTintColor
    }
	

}


