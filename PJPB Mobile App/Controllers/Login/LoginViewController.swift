//
//  LoginViewController.swift
//  PJPB Mobile App
//
//  Created by Raditia Madya on 25/05/18.
//  Copyright © 2018 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var label: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        label.isHidden = true
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.setupUI()
	}

	@IBAction func loginButtonTapped(_ sender: Any) {
		self.login()
	}
	
	@IBAction func createAccountTapped(_ sender: Any) {
		let registerController = RegisterViewController()
		
		present(registerController, animated: true, completion: nil)
	}
	
	
}

extension LoginViewController {
	
	func setupUI() {
		
		self.loginButton.layer.cornerRadius = 10.0
	}
	
	func login() {
		
		guard let email = self.emailTextField.text else {
			return
		}
		guard let password = self.passwordTextField.text else {
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			
			if error != nil {
				self.label.isHidden = false
				self.label.text = "No user record"
				print(error)
				return
			}
			
			let view = EventViewController()
			let navigationController = UINavigationController(rootViewController: view)
			
			self.present(navigationController, animated: true, completion: nil)
		}
	}
}
