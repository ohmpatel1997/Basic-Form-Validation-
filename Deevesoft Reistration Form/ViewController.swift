//
//  ViewController.swift
//  Deevesoft Reistration Form
//
//  Created by Mac on 19/02/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {

	var error:Bool = true
	var dbreference : DatabaseReference!
	
	@IBOutlet weak var nametextfield: UITextField!
	
	@IBAction func submit(_ sender: Any) {
	
		error = validatename(name:nametextfield.text!)
		if(error == false){
			let alert = UIAlertController(title: "Error", message: "please enter valid name", preferredStyle: UIAlertControllerStyle.actionSheet)
			alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
			self.present(alert,animated:true)
			error = true
			nametextfield.text = ""
			return
		}
		error = validateemail(email: emailtextfield.text!)
		if(error == false){
			
			let alert = UIAlertController(title: "Error", message: "please enter valid email", preferredStyle: UIAlertControllerStyle.actionSheet)
			alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
			self.present(alert,animated:true)
			error = true
			emailtextfield.text=""
			return
		}
		error = validatephone(phone:phonetextfield.text!)
		if(error == false){
			let alert = UIAlertController(title: "Error", message: "please enter valid phone", preferredStyle: UIAlertControllerStyle.actionSheet)
			alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
			self.present(alert,animated:true)
			error = true
			phonetextfield.text=""
			return
		}
		if error == true {
			
			
			let dbname = nametextfield.text!
			let dbmessage = commenttextfield.text!
			let phone = phonetextfield.text!
			let values = ["Name" : dbname,
			              "Message" : dbmessage,
				"phone number" : phone]
			
			dbreference.child("Users").childByAutoId().setValue(values)
			
			
			let alert = UIAlertController(title: "Success", message: "Message successfully sent", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
			self.present(alert,animated:true)
			nametextfield.text = ""
			emailtextfield.text = ""
			addresstextfield.text = ""
			phonetextfield.text = ""
			commenttextfield.text = ""
			return
		}
		
	}
	func validatename(name:String) -> Bool {
		let format = "[a-zA-Z]{3,30}"
		let emailpredicate = NSPredicate(format: "SELF MATCHES[c] %@", format)
		return Bool(emailpredicate.evaluate(with: name))
	}
	func validateemail(email:String)->Bool{
		let format = "[A-Z0-9a-z._]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailpredicate = NSPredicate(format: "SELF MATCHES[c] %@", format)
		return Bool(emailpredicate.evaluate(with: email))
	}
	func validatephone(phone:String) -> Bool {
		let format = "[0-9]{10}"
		let phonepredicate = NSPredicate(format: "SELF MATCHES[c] %@", format)
		return Bool(phonepredicate.evaluate(with: phone))
	}
	
			
	
	@IBOutlet weak var commenttextfield: UITextField!
	@IBOutlet weak var phonetextfield: UITextField!
	@IBOutlet weak var addresstextfield: UITextField!
	@IBOutlet weak var emailtextfield: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		//...dismiss keyboard....
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismisskeyboard))
		view.addGestureRecognizer(tap)
		
		
		FirebaseApp.configure()
		dbreference = Database.database().reference()
		
		
		
		
	}
	func dismisskeyboard() {
		view.endEditing(true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

