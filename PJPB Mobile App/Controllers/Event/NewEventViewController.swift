//
//  NewEventViewController.swift
//  PJPB Mobile App
//
//  Created by Raditia Madya on 26/05/18.
//  Copyright © 2018 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NewEventViewController: UIViewController {

	@IBOutlet weak var eventName: UITextField!
	@IBOutlet weak var eventLocation: UITextField!
	@IBOutlet weak var eventDate: UITextField!
	@IBOutlet weak var addEventButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
		
    }

	@IBAction func addEventButtonTapped(_ sender: Any) {
		
		let currentUser = Auth.auth().currentUser?.uid
		
		guard let eventName = self.eventName.text else {
			return
		}
		
		guard let eventLocation = self.eventLocation.text else {
			return
		}
		
		guard let eventDate = self.eventDate.text else {
			return
		}
		
		Database.database().reference().child("users").child(currentUser!).observe(.value, with: { (snapshot) in
			
			var name: String
			
			if let dictionary = snapshot.value as? [String: Any] {
				name = dictionary["name"] as! String
				print(name)
			}
		}, withCancel: nil)
		
		//successfully add event
		let ref = Database.database().reference(fromURL: Helper.URL_DATABASE)
		let eventRef = ref.child("events").childByAutoId()
		let eventValues = ["uid": currentUser,
						   "name": eventName,
						   "location": eventLocation,
						   "date": eventDate]
		
		eventRef.updateChildValues(eventValues) { (error, ref) in
			
			if error != nil {
				print(error)
				return
			}
			
			self.dismiss(animated: true, completion: nil)
			print("Event added")
		}
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension NewEventViewController {
	
	func setupUI() {
		
		navigationItem.title = "Add Blood Donors Event"
		self.addEventButton.layer.cornerRadius = 10.0
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelNewEvent))
		navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xB73D48)
		navigationController?.navigationBar.tintColor = UIColor.white
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
	}
	
	@objc func cancelNewEvent() {
		dismiss(animated: true, completion: nil)
	}
}
