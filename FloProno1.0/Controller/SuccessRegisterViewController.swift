//
//  SuccessRegisterViewController.swift
//  FloProno1.0
//
//  Created by Florian Peyrony on 06/09/2022.
//  Copyright © 2022 Florian Peyrony. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SuccessRegisterViewController: UIViewController {
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpButtonsSkin()
        
        if let user = Auth.auth().currentUser {
            
            // user connected
          //  let username = getNameOfUser()
          //  successLabel.text = "Great the adress :  \(username) has been registered! You can now log in."
        } else {
            fatalError("Aucun utilisateur connecté")
        }
    }
    
    func getNameOfUser() {
        let reference = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
      //  reference.child("users").child(userID!).observeSingleEvent(of: .value) { snapchot in
        //    let value = snapchot.value as? NSDictionary
            
         //   let username = value?("username") as? String ?? "no username"
          //  return username
        //}
    }
    
    func setUpButtonsSkin() {
        logInButton.layer.cornerRadius = 20
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        logInButton.backgroundColor?.withAlphaComponent(0.20)
    }
}
