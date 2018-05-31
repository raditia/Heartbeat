//
//  RegisterViewController.swift
//  PJPB Mobile App
//
//  Created by Raditia Madya on 25/05/18.
//  Copyright © 2018 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var registerButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
	
	@IBAction func registerButtonTapped(_ sender: Any) {
		
		self.register()
	}
	
}

extension RegisterViewController: UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.actionOfReturnKey(textField.tag)
		
		return true
	}
}

extension RegisterViewController {
	
	func setupUI() {
		self.title = "REGISTER"
		
		// MARK: - Delegation text field
		self.nameTextField.returnKeyType = .continue
		self.emailTextField.returnKeyType = .continue
		self.passwordTextField.returnKeyType = .done
		
		self.nameTextField.delegate = self
		self.emailTextField.delegate = self
		self.passwordTextField.delegate = self
		
		// MARK: - Custom view & components
		let cornerRadius: CGFloat = 10.0
		self.emailTextField.layer.cornerRadius = cornerRadius
		self.nameTextField.layer.cornerRadius = cornerRadius
		self.passwordTextField.layer.cornerRadius = cornerRadius
		self.registerButton.layer.cornerRadius = cornerRadius
	}
	
	func actionOfReturnKey(_ tag: Int) {
		switch tag {
		case 0:
			self.emailTextField.becomeFirstResponder()
			break
		case 1:
			self.passwordTextField.becomeFirstResponder()
			break
		case 2:
			self.register()
			break
		default:
			break
		}
	}
	
	func register() {
		
		guard let email = self.emailTextField.text else {
			return
		}
		guard let name = self.nameTextField.text else {
			return
		}
		guard let password = self.passwordTextField.text else {
			return
		}
		
		Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
			
			if error != nil {
				print(error)
				return
			}
			
			guard let uid = user?.uid else {
				return
			}
			
			//successfully registered
			let ref = Database.database().reference(fromURL: Helper.URL_DATABASE)
			let usersRef = ref.child("users").child(uid)
			let values = ["name": name, "email": email]
			
			usersRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
				
				if error != nil {
					print(error)
					return
				}
				
				let view = EventViewController()
				let navigationController = UINavigationController(rootViewController: view)
				
				self.present(navigationController, animated: true, completion: nil)
				
//				self.dismiss(animated: true, completion: nil)
				print("Saved user succesfully")
			})
		}
	}
}
