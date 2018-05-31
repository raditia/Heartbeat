//
//  EventViewController.swift
//  PJPB Mobile App
//
//  Created by Raditia Madya on 26/05/18.
//  Copyright © 2018 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EventViewController: UITableViewController {
	
	let cellId = "cellId"
	var events = [Event]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.setupUI()
		self.checkIfUserLoggedIn()
		fetchEvents()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
		let event = events[indexPath.row]
		
		tableView.rowHeight = 50
		cell.textLabel?.text = event.name
		cell.detailTextLabel?.text = event.location
		
        return cell
    }
	
	func fetchEvents() {
		
		let ref = Database.database().reference()
		let eventDB = ref.child("events")
		
//		ref.child("events").observe(.value, with: { (snapshot) in
//
//			if let dictionary = snapshot.value as? [String: Any] {
//				let event = Event()
//				event.setValuesForKeys(dictionary)
//				self.events.append(event)
//				print(event.name)
//
//			}
//			print(snapshot)
//		}, withCancel: nil)
		
		eventDB.observe(.childAdded) { (snapshot) in
			
			let value = snapshot.value as! Dictionary<String,String>
			
			let date = value["date"]
			let location = value["location"]
			let name = value["name"]
			let uid = value["uid"]
			
			let event = Event()
			event.date = date
			event.location = location
			event.name = name
			event.uid = uid
			
			self.events.append(event)
			self.tableView.reloadData()
			print(snapshot)
			
		}
	}


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
}

extension EventViewController {
	
	func setupUI() {
		
		self.title = "DONOR DARAH"
		
		let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
		navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
		
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newEvent))
		navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xB73D48)
		navigationController?.navigationBar.tintColor = UIColor.white
		navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
	}
	
	func checkIfUserLoggedIn() {
		if Auth.auth().currentUser?.uid == nil {
			perform(#selector(logout), with: nil, afterDelay: 0)
			
		}
		else {
			Database.database().reference().child("users")
		}
	}
	
	@objc func newEvent() {
		
		let newEventController = NewEventViewController()
		let navigationController = UINavigationController(rootViewController: newEventController)
		
		present(navigationController, animated: true, completion: nil)
	}
	
	@objc func logout() {
		
		do {
			let firebaseAuth = Auth.auth()
			try firebaseAuth.signOut()
		}
		catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
		}
		
		let loginController = LoginViewController()
		
		present(loginController, animated: true, completion: nil)
	}
}

